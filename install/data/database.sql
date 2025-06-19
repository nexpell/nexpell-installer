-- nexpell - Datenbankbasis
-- 28.05.2025


-- Tabellenstruktur für Tabelle `logs`
CREATE TABLE IF NOT EXISTS `logs` (
    `logID` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `log_type` VARCHAR(255),
    `log_message` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'logs'

-- Tabellenstruktur für Tabelle `backups`
CREATE TABLE IF NOT EXISTS `backups` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `filename` text NOT NULL,
  `description` text,
  `createdby` int(11) NOT NULL DEFAULT '0',
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'backups'

-- Tabellenstruktur für Tabelle `captcha`
CREATE TABLE IF NOT EXISTS `captcha` (
  `hash` VARCHAR(255) NOT NULL,
  `captcha` INT(11) NOT NULL DEFAULT '0',
  `deltime` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY  (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'captcha'

-- Tabellenstruktur für Tabelle `contact`
CREATE TABLE IF NOT EXISTS `contact` (
  `contactID` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'contact'

-- Tabellenstruktur für Tabelle `email` 
CREATE TABLE IF NOT EXISTS `email` (
  `emailID` int(1) NOT NULL,
  `user` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `port` int(5) NOT NULL,
  `debug` int(1) NOT NULL,
  `auth` int(1) NOT NULL,
  `html` int(1) NOT NULL,
  `smtp` int(1) NOT NULL,
  `secure` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `email` (`emailID`, `user`, `password`, `host`, `port`, `debug`, `auth`, `html`, `smtp`, `secure`) 
VALUES (1, '', '', '', 25, 0, 0, 1, 0, 0);
-- Ende der Tabelle 'email'

-- Tabellenstruktur für Tabelle `lock` 
CREATE TABLE IF NOT EXISTS `site_lock` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `reason` TEXT NOT NULL,
  `time` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Ende der Tabelle 'site_lock'

-- Tabellenstruktur für Tabelle `navigation_dashboard_categories`
CREATE TABLE IF NOT EXISTS `navigation_dashboard_categories` (
  `catID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `modulname` varchar(255) NOT NULL,
  `fa_name` varchar(255) NOT NULL DEFAULT '',
  `sort_art` INT(11) DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`catID`),
  UNIQUE KEY `modulname` (`modulname`, `catID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `navigation_dashboard_categories` (`catID`, `name`, `modulname`, `fa_name`, `sort`) VALUES
(1, '[[lang:de]]System & Einstellungen[[lang:en]]System & Settings[[lang:it]]Sistema e Impostazioni', 'cat_system', 'bi bi-gear', 1),
(2, '[[lang:de]]Statistiken[[lang:en]]Statistics[[lang:it]]Statistiche', 'cat_statistics', 'bi bi-bar-chart-line', 2),
(3, '[[lang:de]]Benutzer & Rollen[[lang:en]]Users & Roles[[lang:it]]Utenti e Ruoli', 'cat_users', 'bi bi-person', 3),
(4, '[[lang:de]]Sicherheit[[lang:en]]Security[[lang:it]]Sicurezza', 'cat_security', 'bi bi-shield-lock', 4),
(5, '[[lang:de]]Teamverwaltung[[lang:en]]Team Management[[lang:it]]Gestione Team', 'cat_team', 'bi bi-people', 5),
(6, '[[lang:de]]Design & Layout[[lang:en]]Design & Layout[[lang:it]]Design e Layout', 'cat_design', 'bi bi-layout-text-window-reverse', 6),
(7, '[[lang:de]]Plugins & Erweiterungen[[lang:en]]Plugins & Extensions[[lang:it]]Plugin ed Estensioni', 'cat_plugins', 'bi bi-puzzle', 7),
(8, '[[lang:de]]Webinhalte[[lang:en]]Website Content[[lang:it]]Contenuti Web', 'cat_content', 'bi bi-card-checklist', 8),
(9, '[[lang:de]]Medien & Projekte[[lang:en]]Media & Projects[[lang:it]]Media e Progetti', 'cat_media', 'bi bi-image', 9),
(10, '[[lang:de]]Header & Slider[[lang:en]]Header & Slider[[lang:it]]Header e Slider', 'cat_slider_header', 'bi bi-fast-forward-btn', 10),
(11, '[[lang:de]]Game & Voice Tools[[lang:en]]Game & Voice Tools[[lang:it]]Game e Voice Tools', 'cat_tools_game', 'bi bi-controller', 11),
(12, '[[lang:de]]Social Media[[lang:en]]Social Media[[lang:it]]Social Media', 'cat_social', 'bi bi-steam', 12),
(13, '[[lang:de]]Downloads & Partner[[lang:en]]Downloads & Partners[[lang:it]]Download e Sponsor', 'cat_partners', 'bi bi-link', 13);
-- Ende der Tabelle 'navigation_dashboard_categories'

-- Tabellenstruktur für Tabelle `navigation_dashboard_links`
CREATE TABLE IF NOT EXISTS `navigation_dashboard_links` (
  `linkID` int(11) NOT NULL AUTO_INCREMENT,
  `catID` int(11) NOT NULL DEFAULT 0,
  `modulname` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `sort` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`linkID`),
  UNIQUE KEY `modulname` (`modulname`, `linkID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `navigation_dashboard_links` (`catID`, `modulname`, `name`, `url`, `sort`) VALUES
(1, 'ac_overview', '[[lang:de]]Webserver-Info[[lang:en]]Webserver Info[[lang:it]]Informazioni Sul Sito', 'admincenter.php?site=overview', 1),
(1, 'ac_settings', '[[lang:de]]Allgemeine Einstellungen[[lang:en]]General Settings[[lang:it]]Impostazioni Generali', 'admincenter.php?site=settings', 2),
(1, 'ac_dashboard_navigation', '[[lang:de]]Admincenter Navigation[[lang:en]]Admincenter Navigation[[lang:it]]Menu Navigazione Admin', 'admincenter.php?site=dashboard_navigation', 3),
(1, 'ac_email', '[[lang:de]]E-Mail[[lang:en]]E-Mail[[lang:it]]E-Mail', 'admincenter.php?site=email', 4),
(1, 'ac_contact', '[[lang:de]]Kontakte[[lang:en]]Contacts[[lang:it]]Contatti', 'admincenter.php?site=contact', 5),
(1, 'ac_database', '[[lang:de]]Datenbank[[lang:en]]Database[[lang:it]]Database', 'admincenter.php?site=database', 6),
(1, 'ac_languages', '[[lang:de]]Sprachen verwalten[[lang:en]]Manage Languages[[lang:it]]Gestisci lingue', 'admincenter.php?site=admin_languages', 7),
(1, 'ac_editlang', '[[lang:de]]Spracheditor[[lang:en]]Language Editor[[lang:it]]Editor di Linguaggi', 'admincenter.php?site=editlang', 8),
(1, 'ac_update_core', '[[lang:de]]Core aktualisieren[[lang:en]]Update Core[[lang:it]]Aggiorna Core', 'admincenter.php?site=update_core', 9),
(2, 'ac_statistic', '[[lang:de]]Seiten Statistiken[[lang:en]]Page Statistics[[lang:it]]Pagina delle Statistiche', 'admincenter.php?site=statistic', 1),
(2, 'ac_visitor_statistic', '[[lang:de]]Besucher Statistiken[[lang:en]]Visitor Statistics[[lang:it]]Statistiche Visitatori', 'admincenter.php?site=visitor_statistic', 2),
(2, 'ac_db_stats', '[[lang:de]]Besucher / Seitenzugriffe[[lang:en]]Visitors / Pageviews[[lang:it]]Visitatori / Visualizzazioni di pagina', 'admincenter.php?site=db_stats', 3),
(3, 'ac_user_roles', '[[lang:de]]Registrierte Benutzer und Rollen[[lang:en]]Registered Users and Roles[[lang:it]]Utenti registrati e ruoli', 'admincenter.php?site=user_roles', 1),
(3, 'ac_role_permissions', '[[lang:de]]Rollenberechtigungen[[lang:en]]Role Permissions[[lang:it]]Permessi dei ruoli', 'admincenter.php?site=admin_role_permissions', 2),
(3, 'ac_admin_log', '[[lang:de]]Admin-Protokoll[[lang:en]]Admin Log[[lang:it]]Registro Admin', 'admincenter.php?site=admin_log', 3),
(4, 'ac_security_overview', '[[lang:de]]Admin Security[[lang:en]]Admin Security[[lang:it]]Sicurezza Admin', 'admincenter.php?site=security_overview', 1),
(6, 'ac_webside_navigation', '[[lang:de]]Webseiten Navigation[[lang:en]]Website Navigation[[lang:it]]Menu Navigazione Web', 'admincenter.php?site=webside_navigation', 1),
(6, 'ac_themes_installer', '[[lang:de]]Themes Installer[[lang:en]]Themes Installer[[lang:it]]Installazione Themes', 'admincenter.php?site=themes_installer', 2),
(6, 'ac_theme', '[[lang:de]]Themes[[lang:en]]Themes[[lang:it]]Temi', 'admincenter.php?site=theme', 3),
(6, 'ac_headstyle', '[[lang:de]]Kopfzeilen-Stil[[lang:en]]Head Style[[lang:it]]Stile intestazione', 'admincenter.php?site=admin_headstyle', 4),
(6, 'ac_startpage', '[[lang:de]]Startseite[[lang:en]]Start Page[[lang:it]]Pagina Principale', 'admincenter.php?site=settings_startpage', 5),
(6, 'ac_static', '[[lang:de]]Statische Seiten[[lang:en]]Static Pages[[lang:it]]Pagine Statiche', 'admincenter.php?site=settings_static', 6),
(6, 'ac_imprint', '[[lang:de]]Impressum[[lang:en]]Imprint[[lang:it]]Impronta Editoriale', 'admincenter.php?site=settings_imprint', 7),
(6, 'ac_privacy_policy', '[[lang:de]]Datenschutz-Bestimmungen[[lang:en]]Privacy Policy[[lang:it]]Informativa sulla Privacy', 'admincenter.php?site=settings_privacy_policy', 8),
(7, 'ac_plugin_manager', '[[lang:de]]Plugin & Widget Manager[[lang:en]]Plugin & Widget Manager[[lang:it]]Gestore di Plugin e Widget', 'admincenter.php?site=plugin_manager', 1),
(7, 'ac_plugin_installer', '[[lang:de]]Plugin Installer[[lang:en]]Plugin Installer[[lang:it]]Installazione Plugin', 'admincenter.php?site=plugin_installer', 2),
(8, 'footer_easy', '[[lang:de]]Footer Easy[[lang:en]]Footer Easy[[lang:it]]Piè di pagina Easy', 'admincenter.php?site=admin_footer_easy', 1);
-- Ende der Tabelle 'navigation_dashboard_links'

-- Tabellenstruktur für Tabelle `navigation_website_main`
CREATE TABLE IF NOT EXISTS `navigation_website_main` (
  `mnavID` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `default` int(11) NOT NULL DEFAULT '1',
  `sort` int(2) NOT NULL DEFAULT '0',
  `isdropdown` int(1) NOT NULL DEFAULT '1',
  `windows` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
  
INSERT INTO `navigation_website_main` (`mnavID`, `name`, `url`, `default`, `sort`, `isdropdown`, `windows`) VALUES
(1, '[[lang:de]]START[[lang:en]]MAIN[[lang:it]]PRINCIPALE', '#', 1, 1, 1, 1),
(2, '[[lang:de]]TEAM[[lang:en]]TEAM[[lang:it]]TEAM', '#', 1, 2, 1, 1),
(3, '[[lang:de]]COMMUNITY[[lang:en]]COMMUNITY[[lang:it]]COMMUNITY', '#', 1, 3, 1, 1),
(4, '[[lang:de]]MEDIEN[[lang:en]]MEDIA[[lang:it]]MEDIA', '#', 1, 4, 1, 1),
(5, '[[lang:de]]SOCIAL[[lang:en]]SOCIAL[[lang:it]]SOCIAL', '#', 1, 5, 1, 1),
(6, '[[lang:de]]INFO[[lang:en]]MISCELLANEOUS[[lang:it]]VARIE', '#', 1, 6, 1, 1);
-- Ende der Tabelle 'navigation_website_main'

-- Tabellenstruktur für Tabelle `navigation_website_sub`
CREATE TABLE IF NOT EXISTS `navigation_website_sub` (
  `snavID` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `mnavID` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `modulname` varchar(100) NOT NULL,
  `url` varchar(255) NOT NULL,
  `sort` int(2) NOT NULL DEFAULT '0',
  `indropdown` int(1) NOT NULL DEFAULT '1',
  `themes_modulname` varchar(255) DEFAULT 'default'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
  
INSERT INTO `navigation_website_sub` (`snavID`, `mnavID`, `name`, `modulname`, `url`, `sort`, `indropdown`, `themes_modulname`) VALUES
(1, 6, '[[lang:de]]Kontakt[[lang:en]]Contact[[lang:it]]Contatti', 'contact', 'index.php?site=contact', 1, 1, 'default'),
(2, 6, '[[lang:de]]Datenschutz[[lang:en]]Privacy Policy[[lang:it]]Informativa sulla Privacy', 'privacy_policy', 'index.php?site=privacy_policy', 2, 1, 'default'),
(3, 6, '[[lang:de]]Impressum[[lang:en]]Imprint[[lang:it]]Impronta Editoriale', 'imprint', 'index.php?site=imprint', 3, 1, 'default');
-- Ende der Tabelle 'navigation_website_sub'


-- Tabellenstruktur für Tabelle `plugins_footer`
CREATE TABLE IF NOT EXISTS `plugins_footer_easy` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `link_number` tinyint(1) NOT NULL COMMENT '1–5',
  `copyright_link_name` varchar(255) NOT NULL DEFAULT '',
  `copyright_link` varchar(255) NOT NULL DEFAULT '',
  `new_tab` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `link_number` (`link_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `plugins_footer_easy` (`id`, `link_number`, `copyright_link_name`, `copyright_link`, `new_tab`) VALUES
(1, 1, '[[lang:de]]Impressum[[lang:en]]Imprint[[lang:it]]Impronta Editoriale', 'index.php?site=imprint', 0),
(2, 2, '[[lang:de]]Datenschutz[[lang:en]]Privacy Policy[[lang:it]]Informativa sulla Privacy', 'index.php?site=privacy_policy', 0),
(3, 3, '[[lang:de]]Kontakt[[lang:en]]Contact[[lang:it]]Contatti', 'index.php?site=contact', 0),
(4, 4, '', '', 0),
(5, 5, '', '', 0);
-- Ende der Tabelle 'plugins_footer'

-- Tabellenstruktur für Tabelle `plugins_startpage_settings_widgets`
CREATE TABLE IF NOT EXISTS `plugins_startpage_settings_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `position` varchar(255) NOT NULL,
  `modulname` varchar(255) NOT NULL,
  `themes_modulname` varchar(255) NOT NULL,
  `widgetname` varchar(255) NOT NULL,
  `widgetdatei` varchar(255) NOT NULL,
  `activated` int(1) DEFAULT '1',
  `sort` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `plugins_startpage_settings_widgets` (`id`, `position`, `modulname`, `themes_modulname`, `widgetname`, `widgetdatei`, `activated`, `sort`) VALUES
(1, 'navigation_widget', 'navigation', 'default', 'Navigation', 'widget_navigation', 1, 1),
(2, 'footer_widget', 'footer_easy', 'default', 'Footer Easy', 'widget_footer_easy', 1, 2);
-- Ende der Tabelle 'plugins_startpage_settings_widgets'

-- Tabellenstruktur für Tabelle `settings`
CREATE TABLE IF NOT EXISTS `settings` (
  `settingID` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `hptitle` VARCHAR(255) NOT NULL,
  `hpurl` VARCHAR(255) NOT NULL,
  `clanname` VARCHAR(255) NOT NULL,
  `clantag` VARCHAR(255) NOT NULL,
  `adminname` VARCHAR(255) NOT NULL,
  `adminemail` VARCHAR(255) NOT NULL CHECK (`adminemail` LIKE '%@%'),
  `since` YEAR NOT NULL DEFAULT '2025',
  `webkey` VARCHAR(255) NOT NULL DEFAULT 'PLACEHOLDER_WEBKEY',
  `seckey` VARCHAR(255) NOT NULL DEFAULT 'PLACEHOLDER_SECKEY',
  `closed` TINYINT(1) NOT NULL DEFAULT 0,
  `default_language` VARCHAR(5) NOT NULL DEFAULT 'de',
  `de_lang` TINYINT(1) DEFAULT 1,
  `en_lang` TINYINT(1) DEFAULT 1,
  `it_lang` TINYINT(1) DEFAULT 1,
  `keywords` TEXT NOT NULL,
  `description` TEXT NOT NULL,
  `modRewrite` TINYINT(1) NOT NULL DEFAULT 0,
  `startpage` VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'settings'

-- Tabellenstruktur für Tabelle `settings_imprint`
CREATE TABLE IF NOT EXISTS `settings_imprint` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `represented_by` varchar(255) NOT NULL,
  `tax_id` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `disclaimer` text DEFAULT NULL,
  `address` varchar(255) DEFAULT '',
  `postal_code` varchar(20) DEFAULT '',
  `city` varchar(100) DEFAULT '',
  `register_office` varchar(100) DEFAULT '',
  `register_number` varchar(100) DEFAULT '',
  `vat_id` varchar(50) DEFAULT '',
  `supervisory_authority` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Ende der Tabelle 'settings_imprint'

-- Tabellenstruktur für Tabelle `themes_installed`
CREATE TABLE IF NOT EXISTS  `themes_installed` (
  `themeID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `version` varchar(20) NOT NULL,
  `author` varchar(100) DEFAULT NULL,
  `preview_image` varchar(255) DEFAULT NULL,
  `description` text,
  `installed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`themeID`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- Ende der Tabelle 'themes_installed'

-- Tabellenstruktur für Tabelle `settings_languages`
CREATE TABLE `settings_languages` (
  `id` int(10) UNSIGNED NOT NULL,
  `iso_639_1` char(2) NOT NULL COMMENT 'ISO 639-1 language code, z.B. "en"',
  `iso_639_2` char(3) DEFAULT NULL COMMENT 'Optional ISO 639-2 code, z.B. "eng"',
  `name_en` varchar(100) NOT NULL COMMENT 'Language name in English, z.B. "English"',
  `name_native` varchar(100) DEFAULT NULL COMMENT 'Native language name, z.B. "Deutsch"',
  `name_de` varchar(100) DEFAULT NULL COMMENT 'Language name in German, z.B. "Deutsch"',
  `active` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Is the language active for selection',
  `flag` varchar(255) DEFAULT NULL COMMENT 'Pfad oder CSS-Klasse für Flagge, z.B. "/admin/images/flags/de.svg" oder "fi fi-de"',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `settings_languages` (`id`, `iso_639_1`, `iso_639_2`, `name_en`, `name_native`, `name_de`, `active`, `flag`, `created_at`, `updated_at`) VALUES
(1, 'dk', 'dan', 'Danish', 'Dansk', 'Dänisch', 1, '/admin/images/flags/dk.svg', NOW(), NULL),
(2, 'nl', 'nld', 'Dutch', 'Nederlands', 'Niederländisch', 1, '/admin/images/flags/nl.svg', NOW(), NULL),
(3, 'en', 'eng', 'English', 'English', 'Englisch', 1, '/admin/images/flags/gb.svg', NOW(), NULL),
(4, 'fi', 'fin', 'Finnish', 'Suomi', 'Finnisch', 1, '/admin/images/flags/fi.svg', NOW(), NULL),
(5, 'fr', 'fra', 'French', 'Français', 'Französisch', 1, '/admin/images/flags/fr.svg', NOW(), NULL),
(6, 'de', 'deu', 'German', 'Deutsch', 'Deutsch', 1, '/admin/images/flags/de.svg', NOW(), NULL),
(7, 'it', 'ita', 'Italian', 'Italiano', 'Italienisch', 1, '/admin/images/flags/it.svg', NOW(), NULL),
(8, 'es', 'spa', 'Spanish', 'Español', 'Spanisch', 1, '/admin/images/flags/es.svg', NOW(), NULL),
(9, 'ru', 'rus', 'Russian', 'Русский', 'Russisch', 1, '/admin/images/flags/ru.svg', NOW(), NULL),
(10, 'tr', 'tur', 'Turkish', 'Türkçe', 'Türkisch', 1, '/admin/images/flags/tr.svg', NOW(), NULL);

-- Ende der Tabelle 'settings_languages'

-- Tabellenstruktur für Tabelle `settings_plugins`
CREATE TABLE IF NOT EXISTS `settings_plugins` (
  `pluginID` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `modulname` VARCHAR(100) NOT NULL,
  `info` TEXT NOT NULL, 
  `admin_file` VARCHAR(255) DEFAULT NULL,
  `activate` TINYINT(1) NOT NULL DEFAULT 1,
  `author` VARCHAR(200) DEFAULT NULL,
  `website` VARCHAR(200) DEFAULT NULL,
  `index_link` VARCHAR(255) DEFAULT NULL,
  `hiddenfiles` TEXT DEFAULT NULL,
  `version` VARCHAR(20) DEFAULT '1.0',
  `path` VARCHAR(255) NOT NULL,
  `status_display` TINYINT(1) NOT NULL DEFAULT 1,
  `plugin_display` TINYINT(1) NOT NULL DEFAULT 1,
  `widget_display` TINYINT(1) NOT NULL DEFAULT 0,
  `delete_display` TINYINT(1) NOT NULL DEFAULT 1,
  `sidebar` ENUM('deactivated','activated','full_activated') NOT NULL DEFAULT 'deactivated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `settings_plugins` (`name`, `modulname`, `info`, `admin_file`, `activate`, `author`, `website`, `index_link`, `hiddenfiles`, `version`, `path`, `status_display`, `plugin_display`, `widget_display`, `delete_display`, `sidebar`) VALUES
('Startpage', 'startpage', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', '', '', '', '', 0, 0, 1, 0, 'full_activated'),
('Privacy Policy', 'privacy_policy', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', 'privacy_policy', '', '', '', 0, 0, 1, 0, 'deactivated'),
('Imprint', 'imprint', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', 'imprint', '', '', '', 0, 0, 1, 0, 'deactivated'),
('Static', 'static', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', 'static', '', '', '', 1, 0, 1, 0, 'deactivated'),
('Error_404', 'error_404', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', 'error_404', '', '', '', 1, 0, 1, 0, 'deactivated'),
('Profile', 'profile', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', 'profile', '', '', '', 1, 0, 1, 0, 'deactivated'),
('Login', 'login', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', 'login', '', '', '', 1, 0, 1, 0, 'deactivated'),
('Lost Password', 'lostpassword', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', 'lostpassword', '', '', '', 1, 0, 1, 0, 'deactivated'),
('Contact', 'contact', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', 'contact', '', '', '', 1, 0, 1, 0, 'deactivated'),
('Register', 'register', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', 'register', '', '', '', 1, 0, 1, 0, 'deactivated'),
('Edit Profile', 'edit_profile', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', 'edit_profile,edit_profile_save', '', '', '', 1, 1, 1, 0, 'deactivated'),
('Report', 'report', '[[lang:de]]Kein Plugin. Bestandteil vom System!!![[lang:en]]No plugin. Part of the system!!![[lang:it]]Nessun plug-in. Parte del sistema!!!', '', 1, '', '', 'report', '', '', '', 1, 0, 1, 0, 'deactivated'),
('Navigation', 'navigation', '[[lang:de]]Mit diesem Plugin könnt ihr euch die Navigation anzeigen lassen.[[lang:en]]With this plugin you can display navigation.[[lang:it]]Con questo plugin puoi visualizzare la Barra di navigazione predefinita.', '', 1, 'T-Seven', 'https://nexpell.de', '', '', '0.3', 'includes/plugins/navigation/', 1, 1, 0, 0, 'deactivated'),
('Footer Easy', 'footer_easy', '[[lang:de]]Mit diesem Plugin könnt ihr einen neuen Footer Easy anzeigen lassen.[[lang:en]]With this plugin you can have a new Footer Easy displayed.[[lang:it]]Con questo plugin puoi visualizzare un nuovo piè di pagina.', 'admin_footer_easy', 1, 'T-Seven', 'https://nexpell.de', '', '', '0.1', 'includes/plugins/footer_easy/', 1, 1, 0, 0, 'deactivated');
-- Ende der Tabelle 'settings_plugins'

-- Tabellenstruktur für Tabelle `settings_plugins_widget`
CREATE TABLE IF NOT EXISTS `settings_plugins_widget` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `modulname` varchar(100) NOT NULL,
  `widgetname` varchar(255) NOT NULL,
  `widgetdatei` varchar(255) NOT NULL,
  `area` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `settings_plugins_widget` (`id`, `modulname`, `widgetname`, `widgetdatei`, `area`) VALUES
(1, 'navigation', 'Navigation', 'widget_navigation', 2),
(2, 'footer_easy', 'Footer Easy', 'widget_footer_easy', 6);
-- Ende der Tabelle 'settings_plugins_widget'

-- Tabellenstruktur für Tabelle `settings_plugins_widget_settings`
CREATE TABLE IF NOT EXISTS `settings_plugins_widget_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `side` varchar(255) NOT NULL,
  `position` varchar(255) NOT NULL,
  `modulname` varchar(100) NOT NULL,
  `themes_modulname` varchar(255) NOT NULL,
  `widgetname` varchar(255) NOT NULL,
  `widgetdatei` varchar(255) NOT NULL,
  `activated` int(1) DEFAULT '1',
  `sort` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT IGNORE INTO `settings_plugins_widget_settings` (`id`, `side`, `position`, `modulname`, `themes_modulname`, `widgetname`, `widgetdatei`, `activated`, `sort`) VALUES
(1, '', 'navigation_widget', 'navigation', 'default', 'Navigation', 'widget_navigation', 1, 0),
(2, '', 'footer_widget', 'footer_easy', 'default', 'Footer Easy', 'widget_footer_easy', 1, 0);
-- Ende der Tabelle 'settings_plugins_widget_settings'

-- Tabellenstruktur für Tabelle `settings_privacy_policy`
CREATE TABLE IF NOT EXISTS `settings_privacy_policy` (
  `privacy_policyID` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `date` DATETIME NOT NULL,
  `privacy_policy_text` mediumtext NOT NULL,
  `editor` int(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO `settings_privacy_policy` (`privacy_policyID`, `date`, `privacy_policy_text`, `editor`) VALUES (1, NOW(), '[[lang:de]] Datenschutz-Bestimmungen in deutscher Sprache.<br /><span style="color:#c0392b"><strong>Konfigurieren Sie bitte Ihre Datenschutz-Bestimmungen!</strong></span><br />[[lang:en]] Privacy Policy in English.<br /><span style="color:#c0392b"><strong>Please configure your Privacy Policy!</strong></span>[[lang:it]] Informativa sulla Privacy in Italiano.<br /><span style="color:#c0392b"><strong>Si prega di configurare l’Informativa sulla Privacy!</strong></span>', 1);
-- Ende der Tabelle 'settings_privacy_policy'

-- Tabellenstruktur für Tabelle `settings_social_media`
CREATE TABLE IF NOT EXISTS `settings_social_media` (
  `socialID` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `twitch` varchar(255) NOT NULL,
  `facebook` varchar(255) NOT NULL,
  `twitter` varchar(255) NOT NULL,
  `youtube` varchar(255) NOT NULL,
  `rss` varchar(255) NOT NULL,
  `vine` varchar(255) NOT NULL,
  `flickr` varchar(255) NOT NULL,
  `linkedin` varchar(255) NOT NULL,
  `instagram` varchar(255) NOT NULL,
  `since` varchar(255) NOT NULL,
  `gametracker` varchar(255) NOT NULL,
  `discord` varchar(255) NOT NULL,
  `steam` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT IGNORE INTO `settings_social_media` (`socialID`, `twitch`, `facebook`, `twitter`, `youtube`, `rss`, `vine`, `flickr`, `linkedin`, `instagram`, `since`, `gametracker`, `discord`, `steam`) VALUES
(1, 'https://www.twitch.tv/pulsradiocom', 'https://www.facebook.com/WebspellRM', 'https://twitter.com/webspell_rm', 'https://www.youtube.com/channel/UCE5yTn9ljzSnC_oMp9Jnckg', '-', '-', '-', '-', '-', '2025', '85.14.228.228:28960', 'https://www.discord.gg/kErxPxb', '-');
-- Ende der Tabelle 'settings_social_media'

-- Tabellenstruktur für Tabelle `settings_startpage`
CREATE TABLE IF NOT EXISTS `settings_startpage` (
  `pageID` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(255) NOT NULL,
  `startpage_text` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `editor` TINYINT(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO settings_startpage (`pageID`, `title`, `startpage_text`, `date`, `editor`) VALUES
(1, 'Next-Generation', 
'<div class="container px-4 py-5" id="icon-grid">
  <h6 class="pb-2 border-bottom">Webspell RM (Next-Generation)</h6>
  <small>Das Bootstrap CMS der Zukunft</small>
</div>', 
CURRENT_TIMESTAMP, '');

-- Ende der Tabelle 'settings_startpage'

-- Tabellenstruktur für Tabelle `settings_static`
CREATE TABLE IF NOT EXISTS `settings_static` (
  `staticID` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `categoryID` int(11) NOT NULL DEFAULT 0,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `date` int(14) NOT NULL,
  `editor` int(1) DEFAULT 0,
  `access_roles` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'settings_static'

-- Tabellenstruktur für Tabelle `settings_widgets`
CREATE TABLE IF NOT EXISTS `settings_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `position` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `modulname` varchar(100) NOT NULL,
  `themes_modulname` varchar(255) NOT NULL,
  `widget` varchar(255) DEFAULT 0,
  `widgetname` varchar(255) DEFAULT 0,
  `widgetdatei` varchar(255) DEFAULT 0,
  `activate` int(11) DEFAULT 0,
  `number` int(1) NOT NULL,
  `sort` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `settings_widgets` (`id`, `position`, `description`, `modulname`, `themes_modulname`, `widget`, `widgetname`, `widgetdatei`, `activate`, `number`, `sort`) VALUES
(1, 'page_navigation_widget', 'page_navigation_widget', 'navigation', 'default', 'widget1', 'Navigation', 'widget_navigation', 0, 1, 1),
(2, 'page_footer_widget', 'page_footer_widget', 'footer_easy', 'default', 'widget2', 'Easy Footer Content', 'widget_easyfooter_content', 0, 1, 0);
-- Ende der Tabelle 'settings_widgets'

-- Tabellenstruktur für Tabelle `settings_widgets`
CREATE TABLE IF NOT EXISTS `tags` (
  `rel` varchar(255) NOT NULL,
  `ID` int(11) NOT NULL,
  `tag` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'settings_widgets'

-- Tabellenstruktur für Tabelle `users`
CREATE TABLE IF NOT EXISTS `users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `registerdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `lastlogin` timestamp NOT NULL DEFAULT current_timestamp(),
  `password_hash` varchar(255) NOT NULL,
  `password_pepper` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_hide` int(1) NOT NULL DEFAULT 1,
  `email_change` varchar(255) NOT NULL,
  `email_activate` varchar(255) NOT NULL,
  `role` int(11) DEFAULT 1,
  `is_active` tinyint(1) DEFAULT 0,
  `is_locked` tinyint(1) NOT NULL DEFAULT 0,
  `activation_code` varchar(64) DEFAULT NULL,
  `activation_expires` int(11) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT 'noavatar.png',
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `gender` varchar(100) NOT NULL DEFAULT 'unknown',
  `town` varchar(255) NOT NULL,
  `birthday` varchar(255) NOT NULL,
  `facebook` varchar(255) NOT NULL,
  `twitter` varchar(255) NOT NULL,
  `twitch` varchar(255) NOT NULL,
  `steam` varchar(255) NOT NULL,
  `instagram` varchar(255) NOT NULL,
  `youtube` varchar(255) NOT NULL,
  `discord` varchar(255) NOT NULL,
  `userpic` varchar(255) NOT NULL,
  `homepage` varchar(255) NOT NULL,
  `about` text NOT NULL,
  `pmgot` int(11) NOT NULL DEFAULT 0,
  `pmsent` int(11) NOT NULL DEFAULT 0,
  `visits` int(11) NOT NULL DEFAULT 0,
  `language` varchar(2) NOT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`userID`),
  KEY `idx_last_update` (`last_update`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'users'

-- Tabellenstruktur für Tabelle `banned_ips`
CREATE TABLE IF NOT EXISTS `banned_ips` (
  `banID` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) NOT NULL,
  `deltime` datetime NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `userID` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`banID`),
  KEY `userID` (`userID`),
  CONSTRAINT `fk_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'banned_ips'

-- Tabellenstruktur für Tabelle `contact` 
CREATE TABLE IF NOT EXISTS `failed_login_attempts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `attempt_time` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('failed','blocked') DEFAULT 'failed',
  `reason` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userID` (`userID`),
  CONSTRAINT `fk_failed_login_user` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'failed_login_attempts'

-- Tabellenstruktur für Tabelle `user_roles`
CREATE TABLE IF NOT EXISTS `user_roles` (
  `roleID` INT(11) NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(50) NOT NULL,
  `description` TEXT DEFAULT NULL,
  `is_default` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`roleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `user_roles` (`roleID`, `role_name`, `description`, `is_default`) VALUES
(1,  'Admin',                'Vollzugriff auf alle Funktionen',                          0),
(2,  'Co-Admin',             'Unterstützt Admin bei Verwaltungsaufgaben',                0),
(3,  'Leader',               'Clan-Leiter, strategische Entscheidungen',                 0),
(4,  'Co-Leader',            'Vertretung des Leaders',                                   0),
(5,  'Squad-Leader',         'Leitet eine eigene Squad-Gruppe',                          0),
(6,  'War-Organisator',      'Organisiert Clanwars und Turniere',                        0),
(7,  'Moderator',            'Betreut Forum und Community-Bereiche',                     0),
(8,  'Redakteur',            'Schreibt News und verwaltet Inhalte',                      0),
(9,  'Member',               'Vollwertiges Clan-Mitglied',                               0),
(10, 'Trial-Member',         'Mitglied auf Probe',                                       0),
(11, 'Gast',                 'Öffentlicher Besucher ohne Login',                         0),
(12, 'Registrierter Benutzer','Angemeldet, aber nicht im Clan',                          0),
(13, 'Ehrenmitglied',        'Ehemalige Mitglieder mit besonderem Status',               0),
(14, 'Streamer',             'Darf Stream-Ankündigungen posten',                         0),
(15, 'Designer',             'Erstellt oder pflegt Grafiken und Layouts',                0),
(16, 'Techniker',            'Hat Zugriff auf technische Einstellungen',                 0);
-- Ende der Tabelle 'user_roles'

-- Tabellenstruktur für Tabelle `user_role_assignments`
CREATE TABLE IF NOT EXISTS `user_role_assignments` (
  `assignmentID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `roleID` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`assignmentID`),
  KEY `roleID` (`roleID`),
  KEY `user_role_assignments` (`userID`) USING BTREE,
  CONSTRAINT `user_role_assignments_admin` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `user_role_assignments_role` FOREIGN KEY (`roleID`) REFERENCES `user_roles` (`roleID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;
-- Ende der Tabelle 'user_role_assignments'

-- Tabellenstruktur für Tabelle `user_sessions`
CREATE TABLE IF NOT EXISTS `user_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `userID` int(11) NOT NULL,
  `user_ip` varchar(45) DEFAULT NULL,
  `session_data` text DEFAULT NULL,
  `browser` text DEFAULT NULL,
  `last_activity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_session` (`session_id`),
  KEY `userID` (`userID`),
  CONSTRAINT `fk_sessions_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'user_sessions'

-- Tabellenstruktur für Tabelle `admin_access_rights`
CREATE TABLE IF NOT EXISTS `admin_access_rights` (
    `adminID` INT(11) NOT NULL,
    `moduleID` INT(11) NOT NULL,
    `access_level` INT(11) DEFAULT 0,
    PRIMARY KEY (`adminID`, `moduleID`),
    FOREIGN KEY (`adminID`) REFERENCES `users`(`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'admin_access_rights'

-- Tabellenstruktur für Tabelle `user_role_admin_navi_rights`
CREATE TABLE IF NOT EXISTS `user_role_admin_navi_rights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleID` int(11) NOT NULL,
  `type` enum('link','category') NOT NULL,
  `modulname` varchar(255) NOT NULL,
  `accessID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_access` (`roleID`, `type`, `modulname`),
  CONSTRAINT `user_role_admin_navi_rights_ibfk_1` FOREIGN KEY (`roleID`) REFERENCES `user_roles` (`roleID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `user_role_admin_navi_rights` (`id`, `roleID`, `type`, `modulname`, `accessID`) VALUES
(1, 1, 'link', 'ac_overview', 1),
(2, 1, 'link', 'ac_visitor_statistic', 3),
(3, 1, 'link', 'ac_settings', 4),
(4, 1, 'link', 'ac_dashboard_navigation', 5),
(5, 1, 'link', 'ac_email', 6),
(6, 1, 'link', 'ac_contact', 7),
(7, 1, 'link', 'ac_database', 8),
(8, 1, 'link', 'ac_theme', 11),
(9, 1, 'link', 'ac_startpage', 12),
(10, 1, 'link', 'ac_static', 13),
(11, 1, 'link', 'ac_imprint', 14),
(12, 1, 'link', 'ac_privacy_policy', 15),
(13, 1, 'link', 'ac_plugin_manager', 16),
(14, 1, 'link', 'ac_plugin_installer', 17),
(15, 1, 'link', 'ac_editlang', 18),
(16, 1, 'link', 'footer_easy', 19),
(17, 1, 'link', 'ac_user_roles', 21),
(18, 1, 'link', 'ac_webside_navigation', 9),
(19, 1, 'link', 'ac_theme_installer', 10),
(20, 1, 'link', 'ac_db_stats', 23),
(21, 1, 'link', 'ac_admin_log', 24),
(22, 1, 'link', 'ac_update_core', 25),
(23, 1, 'link', 'ac_headstyle', 26),
(24, 1, 'link', 'ac_role_permissions', 22),
(25, 1, 'link', 'ac_security_overview', 20),
(26, 1, 'link', 'ac_statistic', 2),
(27, 1, 'link', 'ac_site_lock', 0),
(28, 1, 'link', 'ac_theme_preview', 0),
(29, 1, 'link', 'ac_theme_save', 0),
(30, 1, 'link', 'ac_languages', 28),
(31, 1, 'category', 'cat_system', 1),
(32, 1, 'category', 'cat_statistics', 2),
(33, 1, 'category', 'cat_users', 3),
(34, 1, 'category', 'cat_security', 4),
(35, 1, 'category', 'cat_team', 5),
(36, 1, 'category', 'cat_design', 6),
(37, 1, 'category', 'cat_plugins', 7),
(38, 1, 'category', 'cat_content', 8),
(39, 1, 'category', 'cat_media', 9),
(40, 1, 'category', 'cat_slider_header', 10),
(41, 1, 'category', 'cat_tools_game', 11),
(42, 1, 'category', 'cat_social', 12),
(43, 1, 'category', 'cat_partners', 13);
-- Ende der Tabelle 'user_role_admin_navi_rights'

-- Tabellenstruktur für Tabelle `user_role_permissions`
CREATE TABLE IF NOT EXISTS `user_role_permissions` (
  `roleID` int(11) NOT NULL,
  `permission_key` varchar(50) NOT NULL,
  PRIMARY KEY (`roleID`, `permission_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `user_role_permissions` (`roleID`, `permission_key`) VALUES
(1, 'ckeditor_full'),
(1, 'edit_articles'),
(1, 'manage_users'),
(1, 'view_dashboard_only'),
(2, 'edit_articles'),
(2, 'manage_users'),
(3, 'view_dashboard_only');
-- Ende der Tabelle 'user_role_permissions'

-- Tabellenstruktur für Tabelle `user_register_attempts`
CREATE TABLE IF NOT EXISTS `user_register_attempts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `attempt_time` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('success','failed') NOT NULL DEFAULT 'failed',
  `reason` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ip_address` (`ip_address`),
  KEY `attempt_time` (`attempt_time`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'user_register_attempts'

-- Tabellenstruktur für Tabelle `user_username`
CREATE TABLE IF NOT EXISTS `user_username` (
  `userID` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `username` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'user_username'

-- Tabellenstruktur für Tabelle `user_visitors`
CREATE TABLE IF NOT EXISTS `user_visitors` (
  `visitID` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `userID` int(11) NOT NULL DEFAULT '0',
  `visitor` int(11) NOT NULL DEFAULT '0',
  `date` int(14) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'user_visitors'

-- Tabellenstruktur für Tabelle `visitor_statistics`
CREATE TABLE IF NOT EXISTS `visitor_statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(45) NOT NULL,
  `visit_date` date NOT NULL,
  `pageviews` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `page` varchar(255) DEFAULT NULL,
  `country_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'visitor_statistics'

-- Tabellenstruktur für Tabelle `adminlog`
CREATE TABLE IF NOT EXISTS `adminlog` (
  `logID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `info` text DEFAULT NULL,
  `timestamp` int(11) NOT NULL,
  `ip` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`logID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'adminlog'

-- Tabellenstruktur für Tabelle `admin_audit_log`
CREATE TABLE IF NOT EXISTS `admin_audit_log` (
  `logID` int(11) NOT NULL AUTO_INCREMENT,
  `adminID` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `affected_table` varchar(100) DEFAULT NULL,
  `affected_id` int(11) DEFAULT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL,
  `module` varchar(100) DEFAULT NULL,
  `old_data` text DEFAULT NULL,
  `new_data` text DEFAULT NULL,
  PRIMARY KEY (`logID`),
  KEY `adminID` (`adminID`),
  KEY `affected_table` (`affected_table`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'admin_audit_log'

-- Tabellenstruktur für Tabelle `settings_themes`
CREATE TABLE IF NOT EXISTS `settings_themes` (
  `themeID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `modulname` varchar(100) NOT NULL,
  `pfad` varchar(255) NOT NULL,
  `version` varchar(11) NOT NULL,
  `active` int(11) DEFAULT NULL,
  `themename` varchar(255) NOT NULL,
  `navbar_class` varchar(50) NOT NULL,
  `navbar_theme` varchar(10) NOT NULL,
  `express_active` int(11) NOT NULL DEFAULT '0',
  `logo_pic` varchar(255) DEFAULT '0',
  `reg_pic` varchar(255) NOT NULL,
  `headlines` varchar(255) DEFAULT '0',
  `sort` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`themeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `settings_themes` (`themeID`, `name`, `modulname`, `pfad`, `version`, `active`, `themename`, `navbar_class`, `navbar_theme`, `express_active`, `logo_pic`, `reg_pic`, `headlines`, `sort`) VALUES
(1, 'Default', 'default', 'default', '0.3', 1, 'lux', 'bg-primary', 'dark', 0, 'default_logo.png', 'default_login_bg.jpg', 'headlines_03.css', 1);
-- Ende der Tabelle 'settings_themes'

-- Tabellenstruktur für Tabelle `settings_headstyle_config`
CREATE TABLE IF NOT EXISTS settings_headstyle_config (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  selected_style VARCHAR(32) NOT NULL DEFAULT 'head-style-1'
);

INSERT INTO `settings_headstyle_config` (`id`, `selected_style`) VALUES
(1, 'head-boxes-1');
-- Ende der Tabelle 'settings_headstyle_config'

-- Tabellenstruktur für Tabelle `comments`
CREATE TABLE IF NOT EXISTS comments (
  commentID INT(11) NOT NULL AUTO_INCREMENT,
  plugin VARCHAR(50) NOT NULL,
  itemID INT(11) NOT NULL,
  userID INT(11) NOT NULL,
  comment TEXT NOT NULL,
  date DATETIME NOT NULL DEFAULT current_timestamp(),
  parentID INT(11) DEFAULT 0,
  PRIMARY KEY (commentID),
  KEY plugin_item (plugin, itemID),
  KEY userID (userID),
  CONSTRAINT fk_global_comments_user FOREIGN KEY (userID) REFERENCES users (userID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'comments'

-- Tabellenstruktur für Tabelle ratings
CREATE TABLE IF NOT EXISTS ratings (
  ratingID INT(11) NOT NULL AUTO_INCREMENT,
  plugin VARCHAR(50) NOT NULL,
  itemID INT(11) NOT NULL,
  userID INT(11) NOT NULL,
  rating TINYINT(4) NOT NULL CHECK (rating BETWEEN 0 AND 10),
  date DATETIME NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (ratingID),
  UNIQUE KEY unique_vote (plugin, itemID, userID),
  KEY userID (userID),
  CONSTRAINT fk_global_ratings_user FOREIGN KEY (userID) REFERENCES users (userID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'ratings'

-- Tabellenstruktur für Tabelle user_profiles
CREATE TABLE IF NOT EXISTS user_profiles (
    userID INT UNSIGNED NOT NULL,
    firstname VARCHAR(100) DEFAULT NULL,
    lastname VARCHAR(100) DEFAULT NULL,
    location VARCHAR(150) DEFAULT NULL,
    about_me TEXT DEFAULT NULL,
    avatar VARCHAR(255) DEFAULT NULL,
    age INT UNSIGNED DEFAULT NULL,
    gender VARCHAR(50) DEFAULT NULL,
    sexuality VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (userID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `user_profiles` (`userID`, `firstname`, `lastname`, `location`, `about_me`, `avatar`, `age`, `gender`, `sexuality`) VALUES
(1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- Ende der Tabelle 'user_profiles'

-- Tabellenstruktur für Tabelle user_stats
CREATE TABLE IF NOT EXISTS user_stats (
    userID INT UNSIGNED NOT NULL,
    points INT UNSIGNED DEFAULT 0,
    lastlogin DATETIME DEFAULT NULL,
    registerdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    logins_count INT UNSIGNED DEFAULT 0,
    total_time_online INT UNSIGNED DEFAULT 0, -- in Sekunden
    PRIMARY KEY (userID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'user_stats'

-- Tabellenstruktur für Tabelle user_settings
CREATE TABLE IF NOT EXISTS user_settings (
    userID INT UNSIGNED NOT NULL,
    language VARCHAR(10) DEFAULT 'de',
    dark_mode TINYINT(1) DEFAULT 0,
    email_notifications TINYINT(1) DEFAULT 1,
    private_profile TINYINT(1) DEFAULT 0,
    PRIMARY KEY (userID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `user_settings` (`userID`, `language`, `dark_mode`, `email_notifications`, `private_profile`) VALUES
(1, 'de', 0, 1, 0);
-- Ende der Tabelle 'user_settings'

-- Tabellenstruktur für Tabelle user_socials
CREATE TABLE IF NOT EXISTS user_socials (
    userID INT UNSIGNED NOT NULL,
    facebook VARCHAR(255) DEFAULT NULL,
    twitter VARCHAR(255) DEFAULT NULL,
    instagram VARCHAR(255) DEFAULT NULL,
    website VARCHAR(255) DEFAULT NULL,
    github VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (userID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `user_socials` (`userID`, `facebook`, `twitter`, `instagram`, `website`, `github`) VALUES
(1, NULL, NULL, NULL, NULL, NULL);
-- Ende der Tabelle 'user_socials'

-- Tabellenstruktur für Tabelle plugins_installed
CREATE TABLE IF NOT EXISTS `plugins_installed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `modulname` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `folder` varchar(255) DEFAULT NULL,
  `installed_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'plugins_installed'

-- Tabellenstruktur für Tabelle link_clicks
CREATE TABLE IF NOT EXISTS link_clicks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plugin VARCHAR(50),
    itemID INT,
    url TEXT,
    clicked_at DATETIME,
    ip_address VARCHAR(45),
    user_agent TEXT,
    referrer TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Ende der Tabelle 'link_clicks'
