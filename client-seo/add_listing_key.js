const fs = require('fs');
const path = require('path');

const localesDir = 'src/locales';
const files = fs.readdirSync(localesDir);

const translations = {
  "en.json": "Add Listing",
  "tr.json": "İlan Ekle",
  "de.json": "Eintrag hinzufügen",
  "fr.json": "Ajouter une annonce",
  "es.json": "Añadir anuncio",
  "it.json": "Aggiungi annuncio",
  "ru.json": "Добавить объявление",
  "zh.json": "添加房源",
  "ja.json": "物件を追加",
  "pt.json": "Adicionar anúncio",
  "nl.json": "Advertentie toevoegen",
  "ko.json": "매물 등록",
  "ar.json": "أضف عقاراً",
  "gr.json": "Προσθήκη αγγελίας",
  "da.json": "Tilføj annonce",
  "no.json": "Legg til oppføring",
  "se.json": "Lägg till annons",
  "fi.json": "Lisää ilmoitus",
  "pl.json": "Dodaj ogłoszenie"
};

files.forEach(file => {
  if (file.endsWith('.json')) {
    const filePath = path.join(localesDir, file);
    try {
      const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));
      const text = translations[file] || "Add Listing";
      data["nav.addListing"] = text;
      fs.writeFileSync(filePath, JSON.stringify(data, null, 2), 'utf8');
      console.log(`Updated ${file} with nav.addListing: "${text}"`);
    } catch (err) {
      console.error(`Error updating ${file}:`, err);
    }
  }
});
