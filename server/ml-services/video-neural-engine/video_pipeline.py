#!/usr/bin/env python3
"""
video_pipeline.py
─────────────────────────────────────────────────────────────────────────────
Reservatior AI Video Pipeline
─────────────────────────────────────────────────────────────────────────────
Capabilities:
  1. Video resolution detection (360p → 4K/8K)
  2. PropertyType classification from folder path + details.json
  3. HLS multi-bitrate segmentation (AV1 codec, zero-buffering)
  4. Thumbnail extraction
  5. Multi-language text overlay (TR / EN / AR / RU)
  6. WebP photo conversion
  7. Output organised by: {Country}/{City}/{District}/{PropertyType}/{ListingType}/

Usage:
  python3 video_pipeline.py                    # process all
  python3 video_pipeline.py --dry-run          # list only
  python3 video_pipeline.py --city ISTANBUL    # filter by city
  python3 video_pipeline.py --limit 10         # first N videos
  python3 video_pipeline.py --overlay-only     # only add text overlays
  python3 video_pipeline.py --hls-only         # only HLS segmentation
─────────────────────────────────────────────────────────────────────────────
"""

import os
import sys
import json
import shutil
import subprocess
import argparse
from pathlib import Path
from datetime import datetime
from typing import Optional
import asyncio
import edge_tts

# ─── Config ──────────────────────────────────────────────────────────────────

DATA_ROOT = Path(__file__).parent.parent.parent / "data"
FONT_PATH = "/System/Library/Fonts/Helvetica.ttc"   # macOS built-in
FALLBACK_FONT = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"

# Target languages for text overlay
OVERLAY_LANGUAGES = {
    "tr": {"sale": "SATILIK", "rent": "KİRALIK", "room": "oda", "sqm": "m²"},
    "en": {"sale": "FOR SALE", "rent": "FOR RENT", "room": "bd", "sqm": "sqft"},
    "ar": {"sale": "للبيع", "rent": "للإيجار", "room": "غرفة", "sqm": "م²"},
    "ru": {"sale": "ПРОДАЖА", "rent": "АРЕНДА", "room": "к", "sqm": "м²"},
}

TTS_VOICES = {
    "tr": "tr-TR-AhmetNeural",
    "en": "en-US-ChristopherNeural", 
    "ar": "ar-SA-HamedNeural",
    "ru": "ru-RU-DmitryNeural",
}

def generate_tts_audio(text: str, lang: str, output_path: Path):
    voice = TTS_VOICES.get(lang, TTS_VOICES["en"])
    communicate = edge_tts.Communicate(text, voice)
    asyncio.run(communicate.save(str(output_path)))


# Resolution tiers
RESOLUTION_TIERS = {
    "8K":   (7680, 4320),
    "4K":   (3840, 2160),
    "1080p":(1920, 1080),
    "720p": (1280, 720),
    "480p": (854, 480),
    "360p": (640, 360),
}

# PropertyType enum mapping (from Prisma schema)
PROPERTY_TYPE_MAP = {
    "villa": "VILLA", "konak": "VILLA",
    "daire": "APARTMENT", "residence": "APARTMENT", "rezidans": "APARTMENT",
    "stüdyo": "STUDIO", "studio": "STUDIO",
    "penthouse": "PENTHOUSE",
    "ofis": "OFFICE", "plaza": "OFFICE",
    "dükkan": "RETAIL", "mağaza": "RETAIL",
    "dubleks": "FLAT_MAISONETTE", "dublex": "FLAT_MAISONETTE",
    "müstakil": "DETACHED_HOUSE", "bahçeli": "DETACHED_HOUSE",
    "bungalov": "BUNGALOW",
    "townhouse": "TOWNHOUSE",
    "apart": "APARTMENT",
}

LISTING_TYPE_MAP = {
    "satılık": "SALE", "satilik": "SALE", "sale": "SALE",
    "kiralık": "RENT", "kiralik": "RENT", "rent": "RENT", "günlük": "RENT",
}

# ─── Utilities ────────────────────────────────────────────────────────────────

def log(emoji: str, msg: str):
    print(f"{datetime.now().strftime('%H:%M:%S')} {emoji}  {msg}", flush=True)

def run(cmd: list[str], silent=False) -> subprocess.CompletedProcess:
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0 and not silent:
        print(f"  ⚠️  CMD FAILED: {' '.join(cmd[:5])}")
        print(f"  stderr: {result.stderr[:300]}")
    return result

def get_font() -> str:
    return FONT_PATH if os.path.exists(FONT_PATH) else FALLBACK_FONT

# ─── Video Probe ──────────────────────────────────────────────────────────────

def probe_video(video_path: Path) -> dict:
    """Return width, height, duration, codec, bitrate."""
    result = run([
        "ffprobe", "-v", "quiet", "-print_format", "json",
        "-show_streams", "-show_format", str(video_path)
    ], silent=True)
    if result.returncode != 0:
        return {}
    try:
        data = json.loads(result.stdout)
        vstream = next((s for s in data.get("streams", []) if s.get("codec_type") == "video"), {})
        fmt = data.get("format", {})
        return {
            "width": int(vstream.get("width", 0)),
            "height": int(vstream.get("height", 0)),
            "duration": float(fmt.get("duration", 0)),
            "codec": vstream.get("codec_name", ""),
            "bitrate": int(fmt.get("bit_rate", 0)) // 1000,  # kbps
            "size_mb": os.path.getsize(video_path) / (1024 * 1024),
        }
    except Exception:
        return {}

def classify_resolution(width: int, height: int) -> str:
    for name, (w, h) in RESOLUTION_TIERS.items():
        if width >= w or height >= h:
            return name
    return "360p"

# ─── Details.json Parser ──────────────────────────────────────────────────────

def load_details(folder: Path) -> dict:
    details_path = folder / "details.json"
    if details_path.exists():
        try:
            return json.loads(details_path.read_text(encoding="utf-8"))
        except Exception:
            pass
    return {}

def infer_types_from_path(parts: list[str]) -> tuple[str, str]:
    """Infer PropertyType and ListingType from folder path components."""
    combined = " ".join(parts).lower()
    prop_type = "APARTMENT"
    for kw, pt in PROPERTY_TYPE_MAP.items():
        if kw in combined:
            prop_type = pt
            break
    listing_type = "SALE"
    for kw, lt in LISTING_TYPE_MAP.items():
        if kw in combined:
            listing_type = lt
            break
    return prop_type, listing_type

# ─── Text Overlay Builder ─────────────────────────────────────────────────────

def build_overlay_filter(details: dict, lang: str, resolution: str) -> str:
    """Build ffmpeg drawtext filter string for property info overlay."""
    labels = OVERLAY_LANGUAGES.get(lang, OVERLAY_LANGUAGES["en"])
    font = get_font()

    project  = (details.get("projectName") or "").replace("'", "").replace(":", " ")[:35]
    district = (details.get("district") or "").replace("'", "")
    city     = (details.get("city") or "").replace("'", "")
    room     = details.get("roomType", "")
    area     = details.get("grossArea") or details.get("netArea") or ""
    price    = (details.get("price") or "").replace("'", "")[:25]
    status   = details.get("status", "")

    # Status label
    if "kiralık" in status.lower() or "kiralik" in status.lower():
        status_label = labels["rent"]
    else:
        status_label = labels["sale"]

    # Info line
    parts = []
    if room:    parts.append(f"{room}")
    if area:    parts.append(f"{area} {labels['sqm']}")
    if price:   parts.append(price)
    info_line = "  ·  ".join(parts)

    # Scale font sizes by resolution
    base = 28 if resolution in ("4K", "8K") else 22 if resolution == "1080p" else 18

    # Location line: "Şişli, İstanbul"
    location = ", ".join(filter(None, [district, city]))

    # Build multi-line drawtext (bottom left with dark box)
    def dt(text, y_offset, size):
        safe = text.replace("\\", "\\\\").replace("'", "\\'").replace("%", "\\%").replace(":", "\\:")
        return (
            f"drawtext=fontfile='{font}':"
            f"text='{safe}':"
            f"fontsize={size}:fontcolor=white:"
            f"x=20:y=H-{y_offset}:"
            f"box=1:boxcolor=black@0.55:boxborderw=8"
        )

    filters = []
    y = 28
    if info_line:
        filters.append(dt(info_line, y + base + 12, base - 2))
        y += base + 20
    if project:
        filters.append(dt(project, y + base + 12, base))
        y += base + 20
    if location:
        filters.append(dt(location, y + base + 12, base - 4))
        y += base + 16
    # Status badge top-right
    filters.append(
        f"drawtext=fontfile='{font}':"
        f"text='{status_label}':"
        f"fontsize={base}:fontcolor=white:"
        f"x=W-tw-20:y=20:"
        f"box=1:boxcolor=#E53E3E@0.85:boxborderw=10"
    )

    # Watermark bottom-right
    watermark_size = base - 4
    filters.append(
        f"drawtext=fontfile='{font}':"
        f"text='Reservatior.com':"
        f"fontsize={watermark_size}:fontcolor=white@0.5:"
        f"x=W-tw-20:y=H-th-20"
    )

    return ",".join(filters)

# ─── HLS Segmentation ─────────────────────────────────────────────────────────

def make_hls(input_path: Path, output_dir: Path, resolution: str):
    """Generate AV1-encoded multi-bitrate HLS stream."""
    output_dir.mkdir(parents=True, exist_ok=True)

    # Choose quality targets based on source resolution
    if resolution in ("4K", "8K"):
        profiles = [
            ("1080p", "1920:1080", 38),
            ("720p",  "1280:720",  42),
            ("360p",  "640:360",   46),
        ]
    elif resolution == "1080p":
        profiles = [
            ("720p",  "1280:720",  40),
            ("360p",  "640:360",   44),
        ]
    else:
        profiles = [
            ("360p",  "640:360",  42),
        ]

    segment_lists = []
    for name, scale, crf in profiles:
        seg_dir = output_dir / name
        seg_dir.mkdir(exist_ok=True)
        playlist = str(seg_dir / "index.m3u8")

        cmd = [
            "ffmpeg", "-y", "-i", str(input_path),
            "-vf", f"scale={scale}",
            "-c:v", "libsvtav1", "-preset", "8", "-crf", str(crf),
            "-pix_fmt", "yuv420p10le",
            "-c:a", "libopus", "-b:a", "64k",
            "-hls_time", "4",
            "-hls_playlist_type", "vod",
            "-hls_segment_filename", str(seg_dir / "seg_%03d.ts"),
            playlist,
        ]
        log("🎬", f"  HLS {name} → {playlist}")
        run(cmd)
        segment_lists.append((name, f"{name}/index.m3u8"))

    # Master playlist
    master = ["#EXTM3U", "#EXT-X-VERSION:3"]
    bw_map = {"360p": 400000, "480p": 800000, "720p": 1500000, "1080p": 3000000}
    res_map = {"360p": "640x360", "480p": "854x480", "720p": "1280x720", "1080p": "1920x1080"}
    for name, uri in segment_lists:
        bw  = bw_map.get(name, 800000)
        res = res_map.get(name, "")
        master.append(f'#EXT-X-STREAM-INF:BANDWIDTH={bw},RESOLUTION={res}')
        master.append(uri)
    (output_dir / "master.m3u8").write_text("\n".join(master))
    log("✅", f"  Master playlist → {output_dir}/master.m3u8")

# ─── Thumbnail ────────────────────────────────────────────────────────────────

def make_thumbnail(input_path: Path, output_path: Path, seek: float = 2.0):
    cmd = [
        "ffmpeg", "-y", "-ss", str(seek), "-i", str(input_path),
        "-vframes", "1", "-q:v", "2", str(output_path)
    ]
    run(cmd, silent=True)
    if output_path.exists():
        log("🖼️", f"  Thumbnail → {output_path.name}")
    return output_path.exists()

# ─── Text Overlay Video ───────────────────────────────────────────────────────

def make_overlay_video(input_path: Path, output_path: Path, details: dict, lang: str, resolution: str):
    """Burn property info text overlay and TTS into a copy of the video (web-optimised MP4)."""
    vf = build_overlay_filter(details, lang, resolution)
    
    # 1. Prepare TTS Text
    project = details.get("projectName") or "Harika bir ilan"
    city = details.get("city") or ""
    district = details.get("district") or ""
    price = details.get("price") or ""
    
    tts_text = f"{project}. {city} {district}. {price}."
    if lang == "en":
        tts_text = f"Amazing property: {project}. Located in {city} {district}. Price: {price}."
    elif lang == "ar":
        tts_text = f"عقار مذهل: {project}. يقع في {city} {district}. السعر: {price}."
    elif lang == "ru":
        tts_text = f"Удивительная недвижимость: {project}. Находится в {city} {district}. Цена: {price}."
        
    # 2. Generate TTS Audio file
    tts_audio_path = output_path.with_suffix(".tts.mp3")
    try:
        generate_tts_audio(tts_text, lang, tts_audio_path)
    except Exception as e:
        log("⚠️", f"  TTS generation failed for {lang}: {e}")
        
    # 3. Build FFmpeg command (mix original audio with TTS)
    if tts_audio_path.exists():
        cmd = [
            "ffmpeg", "-y", 
            "-i", str(input_path),
            "-i", str(tts_audio_path),
            "-filter_complex", f"[0:v]{vf}[v];[0:a][1:a]amix=inputs=2:duration=first[a]",
            "-map", "[v]", "-map", "[a]",
            "-c:v", "libx264", "-preset", "fast", "-crf", "23",
            "-pix_fmt", "yuv420p",
            "-c:a", "aac", "-b:a", "128k",
            "-movflags", "+faststart",
            str(output_path),
        ]
    else:
        cmd = [
            "ffmpeg", "-y", "-i", str(input_path),
            "-vf", vf,
            "-c:v", "libx264", "-preset", "fast", "-crf", "23",
            "-pix_fmt", "yuv420p",
            "-c:a", "copy",
            "-movflags", "+faststart",
            str(output_path),
        ]
    result = run(cmd)
    if result.returncode == 0 and output_path.exists():
        log("📝", f"  Overlay ({lang}) → {output_path.name}")
        return True
    return False

# ─── Photo → WebP ─────────────────────────────────────────────────────────────

def convert_photos_to_webp(folder: Path):
    for ext in ("*.jpg", "*.jpeg", "*.JPG", "*.JPEG", "*.png", "*.PNG"):
        for img in folder.glob(ext):
            out = img.with_suffix(".webp")
            if not out.exists():
                run(["ffmpeg", "-y", "-i", str(img), "-quality", "85", str(out)], silent=True)
                if out.exists():
                    log("🖼️", f"  WebP → {out.name} ({out.stat().st_size // 1024}KB)")

# ─── Main Processor ───────────────────────────────────────────────────────────

def process_video_folder(video_path: Path, args) -> dict:
    """Process a single video file and its sibling data."""
    folder = video_path.parent
    details = load_details(folder)

    # Path-based classification
    rel_parts = video_path.relative_to(DATA_ROOT).parts
    prop_type, listing_type = infer_types_from_path(list(rel_parts))

    # Override with details.json if available
    if details.get("status"):
        status = details["status"].lower()
        if "kiralık" in status or "kiralik" in status:
            listing_type = "RENT"
        elif "satılık" in status or "satilik" in status:
            listing_type = "SALE"

    # Probe source video
    info = probe_video(video_path)
    width  = info.get("width", 0)
    height = info.get("height", 0)
    resolution = classify_resolution(width, height)

    city     = (details.get("city") or rel_parts[1] if len(rel_parts) > 1 else "UNKNOWN").upper()
    district = (details.get("district") or rel_parts[2] if len(rel_parts) > 2 else "UNKNOWN").upper()
    project  = details.get("projectName") or folder.name

    log("🎥", f"{resolution} [{width}x{height}] {video_path.name}")
    log("📍", f"  {city} / {district} / {prop_type} / {listing_type}")

    if args.dry_run:
        return {"path": str(video_path), "resolution": resolution, "property_type": prop_type, "listing_type": listing_type}

    # Output dir: data/{Country}/{City}/{District}/{PropertyType}/{ListingType}/{project}/
    country_folder = rel_parts[0] if rel_parts else "TURKİYE"
    out_base = DATA_ROOT / country_folder / city / district / prop_type / listing_type / folder.name
    out_base.mkdir(parents=True, exist_ok=True)

    results = {}

    # 1. Thumbnail
    thumb_path = out_base / "thumbnail.jpg"
    if not thumb_path.exists() or args.force:
        results["thumbnail"] = make_thumbnail(video_path, thumb_path)

    # 2. HLS (skip if overlay_only)
    hls_dir = out_base / "hls"
    if not args.overlay_only and (not hls_dir.exists() or args.force):
        log("📡", f"  Starting HLS segmentation ({resolution})...")
        make_hls(video_path, hls_dir, resolution)
        results["hls"] = True

    # 3. Text overlay videos (skip if hls_only)
    if not args.hls_only:
        overlay_langs = args.langs.split(",") if args.langs else ["tr", "en"]
        for lang in overlay_langs:
            overlay_path = out_base / f"overlay_{lang}.mp4"
            if not overlay_path.exists() or args.force:
                results[f"overlay_{lang}"] = make_overlay_video(
                    video_path, overlay_path, details, lang, resolution
                )

    # 4. Convert photos to WebP
    convert_photos_to_webp(folder)
    if folder != out_base:
        convert_photos_to_webp(out_base)

    # 5. Copy/update details.json with enriched data
    enriched = {
        **details,
        "propertyType": prop_type,
        "listingType": listing_type,
        "resolution": resolution,
        "width": width,
        "height": height,
        "processedAt": datetime.now().isoformat(),
        "hlsPath": str(hls_dir.relative_to(DATA_ROOT)) if (hls_dir / "master.m3u8").exists() else None,
        "thumbnailPath": str(thumb_path.relative_to(DATA_ROOT)) if thumb_path.exists() else None,
    }
    (out_base / "details.json").write_text(json.dumps(enriched, ensure_ascii=False, indent=2))

    return results

# ─── Entry Point ──────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(description="Reservatior AI Video Pipeline")
    parser.add_argument("--dry-run",      action="store_true", help="List videos without processing")
    parser.add_argument("--city",         default=None, help="Filter by city name (e.g. ISTANBUL)")
    parser.add_argument("--limit",        type=int, default=0, help="Process only first N videos")
    parser.add_argument("--force",        action="store_true", help="Reprocess already done videos")
    parser.add_argument("--overlay-only", action="store_true", help="Only generate text overlays")
    parser.add_argument("--hls-only",     action="store_true", help="Only HLS segmentation")
    parser.add_argument("--langs",        default="tr,en", help="Overlay languages, comma-separated (tr,en,ar,ru)")
    parser.add_argument("--resolution",   default=None, help="Filter by source resolution (4K,1080p...)")
    args = parser.parse_args()

    log("🚀", "Reservatior AI Video Pipeline başlatıldı")
    log("📁", f"Data root: {DATA_ROOT}")
    log("🌍", f"Overlay dilleri: {args.langs}")

    # Gather all mp4 files
    mp4_files = sorted(DATA_ROOT.rglob("*.mp4"))

    # Filter
    if args.city:
        mp4_files = [f for f in mp4_files if args.city.upper() in str(f).upper()]
    if args.resolution:
        # Pre-filter by probing (slow, use with small sets)
        filtered = []
        for f in mp4_files:
            info = probe_video(f)
            if classify_resolution(info.get("width", 0), info.get("height", 0)) == args.resolution:
                filtered.append(f)
        mp4_files = filtered

    total = len(mp4_files)
    if args.limit > 0:
        mp4_files = mp4_files[:args.limit]

    log("🎬", f"Toplam video: {total} | İşlenecek: {len(mp4_files)}")

    if args.dry_run:
        log("🧪", "DRY-RUN modu — işlem yapılmayacak:")
        for i, f in enumerate(mp4_files[:50]):
            info = probe_video(f)
            res = classify_resolution(info.get("width", 0), info.get("height", 0))
            print(f"  [{i+1}] {res} {info.get('width', '?')}x{info.get('height', '?')} — {f.relative_to(DATA_ROOT)}")
        return

    # Process
    success, failed = 0, 0
    for i, video_path in enumerate(mp4_files):
        log("▶️", f"[{i+1}/{len(mp4_files)}] {video_path.name}")
        try:
            process_video_folder(video_path, args)
            success += 1
        except Exception as e:
            log("❌", f"Hata: {e}")
            failed += 1

    log("🎉", f"\nPipeline tamamlandı! ✅ {success} başarılı | ❌ {failed} hatalı")

if __name__ == "__main__":
    main()
