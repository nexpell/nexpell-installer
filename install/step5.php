<?php


if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/check_lock.php';

ini_set('display_errors', 1);
error_reporting(E_ALL);

$configPath = dirname(__DIR__) . "/system/config.inc.php";
$error = "";
$success = false;

if (!file_exists($configPath)) {
    die("❌ Konfigurationsdatei fehlt. Bitte zuerst Schritt 2 und 3 durchführen.");
}

require_once $configPath;

$mysqli = @new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
if ($mysqli->connect_error) {
    die("❌ Fehler bei der Datenbankverbindung: " . $mysqli->connect_error);
}

// Platzhalter ersetzen
function replace_placeholders($sql, $replacements) {
    foreach ($replacements as $key => $value) {
        $sql = str_replace('{{' . $key . '}}', $value, $sql);
    }
    return $sql;
}

// SQL-Datei importieren
function import_sql_file($mysqli, $filename, $replacements = []) {
    $sql = file_get_contents($filename);
    if (!$sql) {
        return '❌ Fehler: SQL-Datei konnte nicht geladen werden.';
    }

    $sql = replace_placeholders($sql, $replacements);

    if (!$mysqli->multi_query($sql)) {
        return '❌ Fehler beim Ausführen der SQL-Befehle: ' . $mysqli->error;
    }

    do {
        $mysqli->store_result();
    } while ($mysqli->more_results() && $mysqli->next_result());

    return null;
}

// LoginSecurity einbinden
require_once "../system/classes/LoginSecurity.php";
use webspell\LoginSecurity;

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $admin_user   = trim($_POST['adminuser'] ?? '');
    $admin_email  = trim($_POST['adminmail'] ?? '');
    $admin_pass   = $_POST['adminpass'] ?? '';
    $admin_weburl = trim($_POST['adminweburl'] ?? '');

    if (empty($admin_user) || empty($admin_email) || empty($admin_pass) || empty($admin_weburl)) {
        $error = '❌ Bitte alle Felder ausfüllen.';
    } else {

        // Pepper generieren und verschlüsseln
        $pepper_plain     = LoginSecurity::generatePepper();
        $pepper_encrypted = LoginSecurity::encryptPepper($pepper_plain);

        // Passwort hashen
        $hashed_pass = LoginSecurity::createPasswordHash($admin_pass, $admin_email, $pepper_plain);

        // Session-Daten für nächsten Schritt merken
        $_SESSION['install_adminuser']   = $admin_user;
        $_SESSION['install_adminmail']   = $admin_email;
        $_SESSION['install_adminpass']   = $hashed_pass;
        $_SESSION['install_adminpepper'] = $pepper_encrypted;
        $_SESSION['install_adminweburl'] = $admin_weburl;

        // Replacements für SQL-Datei
        $replacements = [
            'adminuser'   => $admin_user,
            'adminmail'   => $admin_email,
            'adminpass'   => $hashed_pass,
            'adminpepper' => $pepper_encrypted,
            'adminweburl' => $admin_weburl,
        ];

        // Schritt: Admin-Daten importieren
        if (!isset($_SESSION['admin_user_inserted'])) {
            $adminSqlFile = __DIR__ . '/data/admin_user.sql';

            if (!file_exists($adminSqlFile)) {
                die('❌ Admin-SQL-Datei nicht gefunden: ' . $adminSqlFile);
            }

            $error = import_sql_file($mysqli, $adminSqlFile, $replacements);

            if (!$error) {
                $_SESSION['admin_user_inserted'] = true;
                $success = "✅ Admin-Konto erfolgreich erstellt! Du wirst in wenigen Sekunden automatisch zu <strong>Schritt 6</strong> weitergeleitet.";
                echo '<script>
                    setTimeout(function () {
                        window.location.href = "step6.php";
                    }, 5000);
                </script>';
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>nexpell Installation – Schritt 3</title>
    <link href="/install/css/bootstrap.min.css" rel="stylesheet">
    <link href="/install/css/installer.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <div class="text-center">
        <img src="/install/images/logo.png" alt="nexpell Logo" class="install-logo mb-4">
        <h2>Schritt 5: Admin-Konto erstellen</h2>
    </div>

    <div class="card shadow-sm border-0 mt-4">
        <div class="card-body">

    <h3>Administrator-Konto erstellen - Schritt 5</h3>
    <p>In diesem Schritt legst du dein persönliches Administrator-Konto an. Mit diesem Konto erhältst du vollständigen Zugriff auf das Admin-Panel von nexpell und kannst alle Einstellungen, Inhalte und Benutzer verwalten.</p>
<p>Bitte verwende ein sicheres Passwort und bewahre deine Zugangsdaten gut auf.</p>

        <?php if (!$success): ?>
            <form method="post">
                <div class="mb-3">
                <label class="form-label">Benutzername:</label>
                <input class="form-control" type="text" name="adminuser" required></div>
<div class="mb-3">
                <label class="form-label">E-Mail:</label>
                <input class="form-control" type="email" name="adminmail" required></div>
<div class="mb-3">
                <label class="form-label">Passwort:</label>
                <input class="form-control" type="password" name="adminpass" required></div>
<div class="mb-3">
                <label class="form-label">Web-URL:</label>
                <input class="form-control" type="text" name="adminweburl" placeholder="https://deine-seite.de" required></div>
<div class="mb-3">
                <input class="btn btn-primary btn-lg w-100" type="submit" value="Admin-Konto erstellen"></div>
            </form>
        <?php endif; ?>

        <?php if ($error): ?>
            <div class="error"><?= htmlspecialchars($error) ?></div>
        <?php endif; ?>

        <?php if ($success): ?>
            <div class="success">
                <?= $success ?><br><br>
                <!--<a class="btn btn-primary btn-lg w-100" href="step6.php"><strong>Weiter zu Schritt 6 (Abschluss)</strong></a>-->
                <div class="alert alert-success text-center" role="alert">
                    <strong>Du wirst in wenigen Sekunden automatisch zu <strong>Schritt 6</strong> weitergeleitet. (Abschluss)</strong>
                </div>
            </div>
        <?php endif; ?>
    </div>
    

    <div class="card-footer text-center text-muted small">
                            &copy; <?= date("Y") ?> nexpell Installer
                        </div>
</div>

<script src="/install/js/bootstrap.bundle.min.js"></script>
</body>
</html>