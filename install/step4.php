<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
ini_set('display_errors', 1);
error_reporting(E_ALL);

$configPath = dirname(__DIR__) . "/system/config.inc.php";
$sqlFile = __DIR__ . "/data/database.sql";
$error = "";
$success = false;

if (!file_exists($configPath)) {
    die("❌ Konfigurationsdatei nicht gefunden. Bitte zuerst Schritt 2 abschließen.");
}

require_once $configPath;

// Verbindung herstellen
$mysqli = @new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
if ($mysqli->connect_error) {
    die("❌ Fehler bei der Datenbankverbindung: " . $mysqli->connect_error);
}

// SQL-Datei laden und verarbeiten
if ($_SERVER["REQUEST_METHOD"] === "POST") {

    if (!file_exists($sqlFile)) {
        $error = "❌ SQL-Datei wurde nicht gefunden.";
    } else {
        $sqlContent = file_get_contents($sqlFile);
        $queries = array_filter(array_map('trim', explode(";", $sqlContent)));

        $mysqli->begin_transaction();
        try {
            foreach ($queries as $query) {
                if (!empty($query)) {
                    $mysqli->query($query);
                    if ($mysqli->error) {
                        throw new Exception($mysqli->error);
                    }
                }
            }
            $mysqli->commit();
            $success = true;
        } catch (Exception $e) {
            $mysqli->rollback();
            $error = "❌ Fehler beim Importieren der Datenbank: " . $e->getMessage();
        }
    }
}
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>nexpell Installation – Schritt 4</title>
    <link href="/install/css/bootstrap.min.css" rel="stylesheet">
    <link href="/install/css/installer.css" rel="stylesheet">
</head>
<body>
    <div class="container my-5">
        <div class="text-center">
            <img src="/install/images/logo.png" alt="nexpell Logo" class="install-logo mb-4">
            <h2>Schritt 4: Datenbankstruktur importieren</h2>
        </div>

        <div class="card shadow-sm border-0 mt-4">
            <div class="card-body">
                <h3>Datenbankstruktur importieren – Schritt 4</h3>

                <?php if (!$success): ?>
                    <p>Mit einem Klick wird die grundlegende Datenbankstruktur von nexpell automatisch eingerichtet. Dabei werden alle erforderlichen Tabellen, Standardwerte und Konfigurationsdaten aus der Datei <code>install/database.sql</code> in deine MySQL-Datenbank importiert.</p>

                    <p>Dieser Schritt ist essenziell, damit nexpell korrekt funktioniert. Es werden unter anderem folgende Inhalte angelegt:</p>
                    <ul>
                        <li>Systemtabellen für Benutzer, Rollen und Zugriffsrechte</li>
                        <li>Grundeinstellungen des Systems und Standardmodule</li>
                        <li>Beispielinhalte zur besseren Orientierung</li>
                    </ul>

                    <p>Stelle sicher, dass deine Datenbankverbindung korrekt eingerichtet ist und dein Benutzer die nötigen Berechtigungen zum Erstellen von Tabellen hat.</p>
                    <p>Nach dem erfolgreichen Import wirst du automatisch zum nächsten Schritt weitergeleitet, um dein Admin-Konto anzulegen.</p>

                    <form method="post">
                        <input type="submit" class="btn btn-primary btn-lg w-100" value="Datenbank importieren">
                    </form>
                <?php endif; ?>

                <?php if ($error): ?>
                    <div class="alert alert-danger mt-3">
                        <?= htmlspecialchars($error) ?>
                    </div>
                <?php endif; ?>

                <?php if ($success): ?>
                    <div class="alert alert-success mt-3">
                        ✅ Import erfolgreich!
                    </div>
                    <a href="step5.php" class="btn btn-primary btn-lg w-100">Weiter zu Schritt 5 (Admin-Konto)</a>
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


