# EstateAI — Global AI Real Estate Media Platform

Production-grade Flutter frontend for an AI-powered real estate SaaS platform.

---

## ✨ Features

| Module | Description |
|---|---|
| 🔐 Auth | Email/password + Google + Apple OAuth, secure token storage |
| 🏠 Listings | Multi-step create/edit wizard with multi-language fields |
| 🎬 AI Video | One-click video generation with real-time polling |
| 🌍 Multi-language | 20 language support + AI auto-translate + RTL (Arabic) |
| ✏️ Video Editor | Timeline editor, scene reorder, trim, subtitles |
| 🎙️ Subtitles | Auto-generate + translate subtitles across 20 languages |
| 📊 Analytics | Views, watch time, drop-off, country breakdown |
| 💰 Plan System | FREE → TRIAL → PAID → PRO → ULTIMATE → ENTERPRISE |
| 🌙 Dark/Light | Full dark and light theme support |
| 🌐 RTL | Full RTL layout support for Arabic and Hebrew |

---

## 🗂️ Architecture

```
lib/
├── core/
│   ├── theme/          # AppColors, AppTheme, AppRadius, AppSpacing
│   ├── network/        # DioClient with auth/retry/logging interceptors
│   ├── localization/   # SupportedLanguage list + localeProvider (Riverpod)
│   └── constants/
├── features/
│   ├── auth/           # Login screen, OAuth, token management
│   ├── dashboard/      # Overview metrics, listings, active AI jobs
│   ├── listings/       # Multi-step create listing (type → details → media → publish)
│   ├── ai_generation/  # AI video generation with animated pipeline progress
│   ├── video_editor/   # Timeline, subtitles, audio, export
│   ├── analytics/      # Views chart, country breakdown, drop-off
│   └── settings/       # Language, currency, theme, plan, notifications
├── shared/
│   └── widgets/        # GoldButton, PremiumCard, MetricCard, AiStepRow, LanguageChip...
├── l10n/
│   ├── app_en.arb
│   ├── app_tr.arb
│   └── app_ar.arb      # (+ 17 more)
└── main.dart           # ProviderScope + GoRouter + RTL directionality
```

**Clean Architecture** per feature:
```
feature/
  data/
    models/        # JSON serializable models
    repositories/  # API calls via Dio
  domain/
    entities/      # Pure domain objects
    usecases/      # Business logic
  presentation/
    screens/       # Full screen widgets
    widgets/       # Feature-specific widgets
    providers/     # Riverpod state (StateNotifier / AsyncNotifier)
```

---

## 🚀 Setup

### Requirements
- Flutter SDK ≥ 3.22.0
- Dart SDK ≥ 3.3.0
- iOS 14+ / Android API 24+

### Installation

```bash
# Clone repository
git clone https://github.com/your-org/realestate-ai-flutter.git
cd realestate-ai-flutter

# Install dependencies
flutter pub get

# Generate code (freezed, json_serializable, riverpod_generator)
dart run build_runner build --delete-conflicting-outputs

# Run on device
flutter run

# Run on specific platform
flutter run -d ios
flutter run -d android
```

### Environment Config

Create `lib/core/constants/env.dart`:

```dart
class Env {
  static const apiBaseUrl    = 'https://api.estateai.app/v1';
  static const googleClientId = 'YOUR_GOOGLE_CLIENT_ID';
  static const appleServiceId = 'app.estateai.signin';
}
```

### ARB Localization

Regenerate localization code after editing `.arb` files:

```bash
flutter gen-l10n
```

Config in `pubspec.yaml`:
```yaml
flutter:
  generate: true
```

---

## 🎨 Design System

| Token | Value |
|---|---|
| Primary | `#C9A84C` (Gold) |
| Background | `#0C0D10` (Dark) |
| Surface | `#14161B` |
| Card | `#1C1F27` |
| Border | `#2A2D38` |
| Display font | Cormorant Garamond |
| Body font | DM Sans |

---

## 🌍 Supported Languages

EN · TR · AR · DE · FR · ES · IT · RU · ZH · JA · KO · PT · NL · PL · SV · DA · FI · NO · HE · HI

RTL languages: **Arabic (AR)** and **Hebrew (HE)** — full `Directionality` support.

---

## 💳 Plan Tiers

| Plan | Videos/mo | Storage |
|---|---|---|
| Free | 3 | 500 MB |
| Trial | 10 | 2 GB |
| Paid | 50 | 10 GB |
| Pro | 200 | 50 GB |
| Ultimate | 1,000 | 200 GB |
| Enterprise | Unlimited | Unlimited |

---

## 📡 API Integration

All API calls go through `DioClient` with:
- **Auth interceptor** — injects `Bearer` token, auto-refreshes on 401
- **Retry interceptor** — retries up to 3× on 5xx / timeout
- **Logging interceptor** — logs all requests/responses in debug mode

```dart
// Example: start AI video generation job
final response = await dio.post('/listings/$id/generate-video', data: {
  'style': 'luxury',
  'voice': 'female',
  'tone': 'luxury',
  'subtitle_languages': ['en', 'tr', 'ar', 'de'],
});
// poll /jobs/{job_id} every 2s until status == 'completed'
```

---

## 🤖 AI Pipeline

```
Photos uploaded
      ↓
Scene Analysis   ← AI detects room types, generates labels
      ↓
Video Generation ← AI assembles cinematic video
      ↓
Subtitle Gen     ← STT → translated to 20 languages
      ↓
Voiceover Synth  ← TTS with selected voice/tone
      ↓
Final Rendering  ← Aspect ratio, music mix, burn subtitles
      ↓
     Done ✓
```

---

## 📦 Key Packages

| Package | Purpose |
|---|---|
| `flutter_riverpod` | State management |
| `go_router` | Navigation |
| `dio` | HTTP client |
| `flutter_animate` | Animations |
| `fl_chart` | Analytics charts |
| `google_fonts` | Cormorant + DM Sans |
| `flutter_secure_storage` | Token storage |
| `image_picker` | Photo/video uploads |
| `video_player` | Video playback |
| `flutter_localizations` | Multi-language |

---

*Built with Flutter · Clean Architecture · Riverpod · Multi-language AI*
