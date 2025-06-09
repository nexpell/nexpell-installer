# nexpell – Content & Community Management System (2025)

**nexpell** ist ein modernes, vollständig modulares und sicheres Open-Source-CMS für Communities, Esport-Teams, Gilden, Vereine und digitale Projekte – bereit für 2025 und darüber hinaus.

![nexpell Logo](https://www.nexpell.de/assets/logo-nexpell-light.png)

👉 Offizielle Website: [nexpell.de](https://www.nexpell.de)
👉 Forum & Support: [nexpell.de/forum](https://www.nexpell.de/forum)
👉 Dokumentation: [nexpell.de/docs](https://www.nexpell.de/docs)

---

## 🚀 Highlights

* ✅ **1-Datei-Installer für sofortige Installation**
* 🔌 **Modulares Plugin-System**
* 🎨 **Moderne Themes mit Bootstrap 5**
* 🌍 **Mehrsprachigkeit via Sprachdateien**
* 🔐 **DSGVO-konform, reCAPTCHA, Cookie-Consent**
* 🛡️ **Sicher: CSRF-, XSS- und IP-Schutz inklusive**
* 📊 **Integriertes Statistik- & Rollenmanagement**
* 📱 **100 % responsive für Frontend & Admin**
* ⚙️ **PHP 8.1+ & saubere OOP-Architektur**

---

## 📅 Installation in 6 Schritten

nexpell verwendet einen **kompakten Web-Installer**, der automatisch alle benötigten Dateien und Datenbankstrukturen bereitstellt.

### 🔧 Systemanforderungen

* PHP **≥ 8.1**
* MySQL oder MariaDB **≥ 10.3**
* Schreibrechte für `/config`, `/uploads`, usw.
* Apache/Nginx mit `mod_rewrite` empfohlen

❗ Wird eine Voraussetzung nicht erfüllt, wird die Installation gestoppt.

---

### 🛠️ Installationsschritte

1. **Lade den offiziellen Installer herunter**
   👉 [Download Installer (installer.php)](https://www.nexpell.de/download)

2. **Lade `installer.php` in das Root-Verzeichnis deines Webservers**

3. **Öffne im Browser:** `https://deine-domain.tld/installer.php`

4. **Folge den Installationsschritten:**

   * Serverprüfung
   * Datenbankzugang
   * Systemdateien und Tabellen laden
   * Admin-Benutzer anlegen
   * Spracheinstellungen & Grundeinstellungen
   * Abschluss und Sicherheits-Hinweise

5. Das System wird automatisch eingerichtet, konfiguriert und bereitgestellt

6. **Entferne `installer.php` nach der Installation**

---

## 📁 Systemstruktur

```plaintext
/admin/             → Adminpanel mit modularer Oberfläche  
/includes/          → Systemfunktionen & Datenbankklassen  
/plugins/           → Erweiterbare Module & Plugins  
/themes/            → Design-Themes  
/system/            → Template-Engine, Router, Auth  
/config/            → Konfigurationsdateien (automatisch erzeugt)  
/install/           → Setup-Dateien (werden entfernt)  
/uploads/           → Bilder, Downloads, Medien etc.
```

---

## 🧹 Erweiterbarkeit

* Eigene Themes über `/themes/`
* Eigene Plugins in `/plugins/`
* Integriertes Routing & Zugriffskontrolle
* Eigene Module im Adminbereich
* Eigene Blöcke mit `{{ platzhalter }}`-Syntax
* Vollständige OOP-Entwicklung möglich

---

## 📚 Dokumentation & Hilfe

* 📖 Offizielle Doku: [nexpell.de/docs](https://www.nexpell.de/docs)
* 💬 Community-Forum: [nexpell.de/forum](https://www.nexpell.de/forum)
* 🐞 Bug melden: [github.com/nexpell/nexpell/issues](https://github.com/nexpell/nexpell/issues)

---

## 🤝 Mitwirken

Wir freuen uns über Pull Requests, Fehlerberichte und neue Ideen.
Ein Contributing Guide wird bald verfügbar sein.

---

## 📜 Lizenz

**nexpell** ist freie Software unter der [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html)
Copyright © 2025
[nexpell.de](https://www.nexpell.de)
