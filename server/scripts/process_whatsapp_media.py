import os
import shutil
import json
import argparse
import re
import pandas as pd

districts = ["Adalar", "Arnavutköy", "Ataşehir", "Avcılar", "Bağcılar", "Bahçelievler", "Bakırköy", "Başakşehir", "Bayrampaşa", "Beşiktaş", "Beykoz", "Beylikdüzü", "Beyoğlu", "Büyükçekmece", "Çatalca", "Çekmeköy", "Esenler", "Esenyurt", "Eyüpsultan", "Fatih", "Gaziosmanpaşa", "Güngören", "Kadıköy", "Kağıthane", "Kartal", "Küçükçekmece", "Maltepe", "Pendik", "Sancaktepe", "Sarıyer", "Silivri", "Sultanbeyli", "Sultangazi", "Şile", "Şişli", "Tuzla", "Ümraniye", "Üsküdar", "Zeytinburnu"]

def clean_project_name(text):
    if not text:
        return ""
    # Strip emojis
    clean = re.sub(r'[\u2600-\u27BF\U0001f300-\U0001f9ff\U0001f600-\U0001f64f\U0001f680-\U0001f6ff]', '', text)
    # Strip non-alphanumeric except spaces, hyphens, and underscores
    clean = re.sub(r'[^a-zA-Z0-9çğıöşüÇĞİÖŞÜ\s\-_]', '', clean)
    # Strip multiple spaces
    clean = re.sub(r'\s+', ' ', clean)
    return clean.strip()

def normalize(s):
    if not s:
        return ""
    s = s.lower()
    s = s.replace('ı', 'i').replace('ö', 'o').replace('ü', 'u').replace('ş', 's').replace('ç', 'c').replace('ğ', 'g')
    s = s.replace('i̇', 'i')
    return "".join(c for c in s if c.isalnum())

normalized_districts = {normalize(d): d for d in districts}

project_district_map = {
    "1453": "Sarıyer",
    "acarkent": "Beykoz",
    "akkoza": "Esenyurt",
    "alice": "Çekmeköy",
    "anthill": "Şişli",
    "avangarden": "Sarıyer",
    "batisehir": "Bağcılar",
    "bellevue": "Beşiktaş",
    "istinye": "Sarıyer",
    "istwest": "Bahçelievler",
    "kanyon": "Şişli",
    "maslak": "Sarıyer",
    "metropol": "Ataşehir",
    "mashattan": "Sarıyer",
    "maya": "Beşiktaş",
    "myhome": "Sarıyer",
    "nurol": "Sarıyer",
    "platin": "Beşiktaş",
    "sarikonaklar": "Beşiktaş",
    "selenium": "Beşiktaş",
    "skyland": "Sarıyer",
    "sapphire": "Kağıthane",
    "terrace": "Şişli",
    "tema": "Küçükçekmece",
    "torun": "Şişli",
    "trump": "Şişli",
    "ucaksavar": "Beşiktaş",
    "ulus": "Beşiktaş",
    "uphill": "Ataşehir",
    "upcity": "Kartal",
    "vadi": "Sarıyer",
    "aquacity": "Ümraniye",
    "astoria": "Şişli",
    "avrupa": "Şişli",
    "bebek": "Beşiktaş",
    "beyoglu": "Beyoğlu",
    "piyalepasa": "Beyoğlu",
    "eclipse": "Sarıyer",
    "innova": "Esenyurt",
    "levent": "Şişli",
    "life": "Sarıyer",
    "ottomare": "Zeytinburnu",
    "polat": "Şişli",
    "royal": "Şişli",
    "savoy": "Beşiktaş",
    "seba": "Sarıyer",
    "sehrizar": "Üsküdar",
    "zorlu": "Beşiktaş"
}

def find_district_from_text(text):
    if not text:
        return None
    norm_text = normalize(text)
    for norm_d, orig_d in normalized_districts.items():
        if norm_d == norm_text or norm_d in norm_text:
            return orig_d
    return None

def find_district_from_hint(filename, body):
    if filename:
        norm_fn = normalize(filename)
        for key, dist in project_district_map.items():
            if key in norm_fn:
                return dist
        for norm_d, orig_d in normalized_districts.items():
            if norm_d in norm_fn:
                return orig_d
    if body:
        norm_body = normalize(body)
        for key, dist in project_district_map.items():
            if key in norm_body:
                return dist
        for norm_d, orig_d in normalized_districts.items():
            if norm_d in norm_body:
                return orig_d
    return None

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--file-path', default='')
    parser.add_argument('--filename', default='')
    parser.add_argument('--message-body', default='')
    parser.add_argument('--mimetype', default='')
    
    args = parser.parse_args()
    
    file_path = args.file_path
    filename = args.filename
    body = args.message_body
    mimetype = args.mimetype
    
    target_dir = "/Users/os2026/Downloads/Reservatior/server/data/TURKİYE/ISTANBUL"
    
    district = None
    is_excel = (filename.endswith(('.xlsx', '.xls')) or 'sheet' in mimetype or 'excel' in mimetype) if filename else False
    
    if is_excel and file_path and os.path.exists(file_path):
        try:
            df = pd.read_excel(file_path)
            for col in df.columns:
                if district:
                    break
                district = find_district_from_text(str(col))
                if district:
                    break
                sample_vals = df[col].dropna().head(30).astype(str)
                for val in sample_vals:
                    district = find_district_from_text(val)
                    if district:
                        break
        except Exception as e:
            print(f"Error parsing excel content: {e}")
            
    if not district:
        district = find_district_from_hint(filename, body)
        
    if not district:
        district = "Bilinmeyen_Proje"
        
    project_name = None
    if filename:
        project_name = os.path.splitext(filename)[0]
    if not project_name or project_name.lower() in ['sheet1', 'table1', 'data', 'document', 'file']:
        if body:
            lines = [l.strip() for l in body.split('\n') if l.strip()]
            if lines:
                project_name = lines[0][:30]
    if not project_name:
        import time
        project_name = f"Import_{int(time.time())}"
        
    project_name = clean_project_name(project_name)
    if not project_name:
        import time
        project_name = f"Import_{int(time.time())}"
        
    if filename:
        fn_name, fn_ext = os.path.splitext(filename)
        clean_fn = clean_project_name(fn_name)
        if not clean_fn:
            import time
            clean_fn = f"file_{int(time.time())}"
        filename = f"{clean_fn}{fn_ext}"
    
    proj_dir = os.path.join(target_dir, district, project_name)
    os.makedirs(proj_dir, exist_ok=True)
    
    if file_path and os.path.exists(file_path):
        if is_excel:
            try:
                df = pd.read_excel(file_path)
                csv_path = os.path.join(proj_dir, f"{project_name}.csv")
                df.to_csv(csv_path, index=False, encoding='utf-8')
                print(f"Converted Excel to CSV: {csv_path}")
            except Exception as e:
                print(f"Failed to convert Excel to CSV, copying original: {e}")
                shutil.copy2(file_path, os.path.join(proj_dir, filename))
        else:
            dest_file_path = os.path.join(proj_dir, filename)
            shutil.copy2(file_path, dest_file_path)
            print(f"Copied file to: {dest_file_path}")
        
    if body:
        with open(os.path.join(proj_dir, "message.txt"), "w", encoding="utf-8") as f:
            f.write(body)
            
    details = {
        "country": "TURKİYE",
        "city": "ISTANBUL",
        "district": district,
        "projectName": project_name,
        "price": "",
        "roomType": "",
        "grossArea": "",
        "netArea": "",
        "citizenship": ""
    }
    with open(os.path.join(proj_dir, "details.json"), "w", encoding="utf-8") as f:
        json.dump(details, f, ensure_ascii=False, indent=2)
        
    print(f"Import completed successfully into {district}/{project_name}")

if __name__ == '__main__':
    main()
