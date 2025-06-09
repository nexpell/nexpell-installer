<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/check_lock.php';

ini_set('display_errors', 1);
error_reporting(E_ALL);
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$configPath = dirname(__DIR__) . "/system/config.inc.php";
$error = "";
$success = false;

if (!file_exists($configPath)) {
    die("❌ Konfigurationsdatei fehlt. Bitte zuerst Schritt 2 und 3 durchführen.");
}

require_once $configPath;

$_database = @new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
if ($_database->connect_error) {
    die("❌ Fehler bei der Datenbankverbindung: " . $_database->connect_error);
}

// Reset: Admin-Daten löschen
if (isset($_GET['reset']) && $_GET['reset'] === '1') {
    echo "🧹 Debug: Admin-Datenbankeinträge werden entfernt...<br>";
    
    $_database->query("DELETE FROM user_role_assignments WHERE assignmentID = 1");
    $_database->query("DELETE FROM users WHERE userID = 1");
    $_database->query("DELETE FROM contact WHERE contactID = 1");
    $_database->query("DELETE FROM user_username WHERE userID = 1");
    $_database->query("DELETE FROM settings WHERE settingID = 1");
    $_database->query("DELETE FROM settings_imprint WHERE id = 1");

    unset($_SESSION['admin_user_inserted']);
    unset($_SESSION['install_adminuser']);
    unset($_SESSION['install_adminmail']);
    unset($_SESSION['install_adminpass']);
    unset($_SESSION['install_adminpepper']);
    unset($_SESSION['install_adminweburl']);

    echo "✅ Debug: Reset abgeschlossen.<br><br>";
}

// Platzhalter ersetzen
function replace_placeholders(string $sql, array $replacements): string {
    global $_database;
    foreach ($replacements as $key => $value) {
        $escapedValue = $_database->real_escape_string($value);
        $sql = str_replace('{' . $key . '}', $escapedValue, $sql);
    }
    return $sql;
}

// SQL-Datei importieren
function import_sql_file($_database, $filename, $replacements = []) {
    $sql = file_get_contents($filename);
    if (!$sql) return '❌ Fehler: SQL-Datei konnte nicht geladen werden.';
    
    $sql = replace_placeholders($sql, $replacements);

    if (!$_database->multi_query($sql)) {
        return '❌ Fehler beim Ausführen der SQL-Befehle: ' . $_database->error;
    }

    do {
        if ($result = $_database->store_result()) {
            $result->free();
        } elseif ($_database->error) {
            echo "⚠️ Fehler in einem SQL-Teil: " . $_database->error . "<br>";
        }
    } while ($_database->more_results() && $_database->next_result());

    return null;
}

// LoginSecurity laden
require_once "../system/classes/LoginSecurity.php";
use webspell\LoginSecurity;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $admin_user   = trim($_POST['adminuser'] ?? '');
    $admin_email  = trim($_POST['adminmail'] ?? '');
    $admin_pass   = $_POST['adminpass'] ?? '';
    $admin_weburl = trim($_POST['adminweburl'] ?? '');

    if (empty($admin_user) || empty($admin_email) || empty($admin_pass) || empty($admin_weburl)) {
        $error = '❌ Bitte alle Felder ausfüllen.';
    } else {

        $pepper_plain     = LoginSecurity::generatePepper();
        $pepper_encrypted = LoginSecurity::encryptPepper($pepper_plain);
        $hashed_pass      = LoginSecurity::createPasswordHash($admin_pass, $admin_email, $pepper_plain);

        $_SESSION['install_adminuser']   = $admin_user;
        $_SESSION['install_adminmail']   = $admin_email;
        $_SESSION['install_adminpass']   = $hashed_pass;
        $_SESSION['install_adminpepper'] = $pepper_encrypted;
        $_SESSION['install_adminweburl'] = $admin_weburl;

        $replacements = [
            'adminuser'   => $admin_user,
            'adminmail'   => $admin_email,
            'adminpass'   => $hashed_pass,
            'adminpepper' => $pepper_encrypted,
            'adminweburl' => $admin_weburl,
        ];

        // Prüfen, ob Admin-User bereits existiert
        $checkStmt = $_database->prepare("SELECT 1 FROM users WHERE userID = 1");
        $checkStmt->execute();
        $checkStmt->store_result();
        $user_exists = $checkStmt->num_rows > 0;
        $checkStmt->close();

        if (!$user_exists) {
            $adminSqlFile = __DIR__ . '/data/admin_user.sql';
            if (!file_exists($adminSqlFile)) {
                die('❌ Admin-SQL-Datei nicht gefunden: ' . $adminSqlFile);
            }

            $error = import_sql_file($_database, $adminSqlFile, $replacements);

            if (!$error) {
                $_SESSION['admin_user_inserted'] = true;
                $success = "✅ Admin-Konto erfolgreich erstellt! Du wirst in wenigen Sekunden automatisch zu <strong>Schritt 6</strong> weitergeleitet.";
                echo '<script>
                    setTimeout(function () {
                        window.location.href = "step6.php";
                    }, 5000);
                </script>';
            }
        } else {
            $error = "ℹ️ Admin-User existiert bereits. Du kannst <a href='?reset=1' class='btn btn-sm btn-outline-danger'>hier zurücksetzen</a>.";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <title>nexpell Installation – Schritt 5</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            <h3>Administrator-Konto erstellen</h3>
            <p>Lege dein persönliches Admin-Konto an. Dieses Konto hat Vollzugriff auf alle Funktionen.</p>

            <?php if (!$success): ?>
                <form method="post">
                    <div class="mb-3">
                        <label class="form-label">Benutzername:</label>
                        <input class="form-control" type="text" name="adminuser" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">E-Mail:</label>
                        <input class="form-control" type="email" name="adminmail" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Passwort:</label>
                        <input class="form-control" type="password" name="adminpass" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Web-URL:</label>
                        <input class="form-control" type="text" name="adminweburl" placeholder="https://deine-seite.de" required>
                    </div>
                    <div class="mb-3">
                        <input class="btn btn-primary btn-lg w-100" type="submit" value="Admin-Konto erstellen">
                    </div>
                </form>
            <?php endif; ?>

            <?php if ($error): ?>
                <div class="alert alert-danger"><?= $error ?></div>
            <?php endif; ?>

            <?php if ($success): ?>
                <div class="alert alert-success">
                    <?= $success ?><br><br>
                    <div class="text-center text-muted small">
                        Du wirst in wenigen Sekunden automatisch weitergeleitet.
                    </div>
                </div>
            <?php endif; ?>
        </div>
        <div class="card-footer text-center text-muted small">
            &copy; <?= date("Y") ?> nexpell Installer
        </div>
    </div>
</div>
<script src="/install/js/bootstrap.bundle.min.js"></script>
</body>
</html>
