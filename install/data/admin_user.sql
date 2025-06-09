-- nexpell - Datenbankbasis
-- 28.05.2025

INSERT INTO `users` (`registerdate`, `lastlogin`, `password_hash`, `password_pepper`, `username`, `email`, `email_hide`, `email_change`, `email_activate`, `role`, `is_active`, `is_locked`, `activation_code`, `activation_expires`, `avatar`, `firstname`, `lastname`, `gender`, `town`, `birthday`, `facebook`, `twitter`, `twitch`, `steam`, `instagram`, `youtube`, `discord`, `userpic`, `homepage`, `about`, `pmgot`, `pmsent`, `visits`, `language`, `last_update`) VALUES
(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '{{adminpass}}', '{{adminpepper}}', '{{adminuser}}', '{{adminmail}}', 1, '', '', 1, 1, 0, NULL, NULL, 'noavatar.png', '', '', 'select_gender', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', NULL);

INSERT INTO `user_role_assignments` (`assignmentID`, `userID`, `roleID`, `created_at`, `assigned_at`) 
VALUES ('', 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO `contact` (`name`, `email`, `sort`) VALUES
('Administrator', '{{adminmail}}', 1);

INSERT INTO `settings` (
  `hptitle`, `hpurl`, `clanname`, `clantag`, `adminname`, `adminemail`, `since`,
  `webkey`, `seckey`, `closed`, `default_language`, `de_lang`, `en_lang`, `it_lang`,
  `keywords`, `description`, `modRewrite`, `startpage`
) VALUES (
  'nexpell', '{{adminweburl}}', 'Mein Clan / Verein', '[RM]', '{{adminuser}}', '{{adminmail}}', 2025,
  'PLACEHOLDER_WEBKEY', 'PLACEHOLDER_SECKEY', 0, 'de', 1, 1, 1,
  'nexpell, CMS, Community-Management, Esport CMS, Webdesign, Clan-Design, Templates, Plugins, Addons, Mods, Anpassungen, Modifikationen, Tutorials, Downloads, Plugin-Entwicklung, Design-Anpassungen, Website-Builder, Digitales Projektmanagement', 'nexpell ist ein modernes, modulares CMS für Communities, Esport-Teams und digitale Projekte – mit Plugins, Templates, Tutorials und einfacher Anpassbarkeit.', 0, 'startpage'
);

INSERT IGNORE INTO `user_username` (`userID`, `username`) VALUES (1, '{{adminuser}}');

INSERT IGNORE INTO `settings_imprint` (`id`, `type`, `company_name`, `represented_by`, `tax_id`, `email`, `website`, `phone`, `disclaimer`) VALUES
(1, 'private', '{{adminuser}}', '', '', '{{adminmail}}', '{{adminweburl}}', '+49 123 4567890', '[[lang:de]] Dies ist ein deutscher Haftungsausschluss. [[lang:en]] This is an English disclaimer. [[lang:it]] Questo Ã¨ un disclaimer italiano.');
