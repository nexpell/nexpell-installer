<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/check_lock.php';

ini_set('display_errors', 1);
error_reporting(E_ALL);

$configPath = dirname(__DIR__) . "/system/config.inc.php";
$error = "";
$success_messages = [];
$requirements_met = true;

// PHP-Version prüfen
$required_php_version = '8.1.0';
if (version_compare(PHP_VERSION, $required_php_version, '<')) {
    $error .= "❌ PHP-Version zu niedrig! (Aktuell: " . PHP_VERSION . ")<br>";
    $requirements_met = false;
} else {
    $success_messages[] = "✅ PHP-Version ist korrekt! (Aktuell: " . PHP_VERSION . ")";
}

// MySQL-Verbindung über config.inc.php testen (wenn Datei existiert)
$_database = null;

if (file_exists($configPath)) {
    $config_content = file_get_contents($configPath);

    // Nur laden, wenn Konfiguration NICHT leer ist
    if (strpos($config_content, "new mysqli") !== false &&
        strpos($config_content, "''") === false) {
        include($configPath);

        if ($_database instanceof mysqli && !$_database->connect_error) {
            $mysql_version = $_database->server_info;

            if (strpos($mysql_version, 'MariaDB') !== false) {
                $success_messages[] = "✅ MariaDB-Version erkannt! ($mysql_version)";
            } elseif (version_compare($mysql_version, '8.0', '<')) {
                $error .= "❌ MySQL-Version zu niedrig! (Aktuell: $mysql_version)<br>";
                $requirements_met = false;
            } else {
                $success_messages[] = "✅ MySQL-Version ist korrekt! ($mysql_version)";
            }
        } else {
            $error .= "⚠️ config.inc.php ist vorhanden, aber enthält ungültige Verbindungsdaten.<br>";
            $requirements_met = false;
        }
    }
}

// Schreibrechte prüfen
$css_file = __DIR__ . '/../includes/themes/default/css/stylesheet.css';
if (!is_writable($css_file)) {
    $error .= "❌ Die Datei stylesheet.css ist nicht schreibbar.<br>";
    $requirements_met = false;
} else {
    $success_messages[] = "✅ Die Datei stylesheet.css ist schreibbar.";
}

// Initialwerte
$DB_HOST = $DB_USER = $DB_PASS = $DB_NAME = '';
$error_message = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $requirements_met) {
    $DB_HOST = trim($_POST['DB_HOST'] ?? '');
    $DB_USER = trim($_POST['DB_USER'] ?? '');
    $DB_PASS = $_POST['DB_PASS'] ?? '';
    $DB_NAME = trim($_POST['DB_NAME'] ?? '');

    try {
        $conn = new mysqli($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);

        if ($conn->connect_error) {
            throw new mysqli_sql_exception("Verbindung zur Datenbank fehlgeschlagen: " . $conn->connect_error);
        }

        // Datenbankverbindung war erfolgreich, also schreibe die config.inc.php
        $configContent = "<?php\n";
$configContent .= "/**\n * nexpell Konfigurationsdatei\n * Automatisch generiert durch Installer\n */\n";
$configContent .= "define('DB_HOST', '" . addslashes($DB_HOST) . "');\n";
$configContent .= "define('DB_USER', '" . addslashes($DB_USER) . "');\n";
$configContent .= "define('DB_PASS', '" . addslashes($DB_PASS) . "');\n";
$configContent .= "define('DB_NAME', '" . addslashes($DB_NAME) . "');\n";
$configContent .= "?>";

file_put_contents($configPath, $configContent);
        

        $configFile = dirname(__DIR__) . '/system/config.inc.php';

        if (file_put_contents($configFile, $configContent)) {
            $success_messages[] = "✅ config.inc.php wurde erfolgreich erstellt!";
        } else {
            $error_message = "❌ Fehler beim Erstellen der config.inc.php Datei.";
        }

        $_SESSION['db_data'] = [
            'DB_HOST' => $DB_HOST,
            'DB_USER' => $DB_USER,
            'DB_PASS' => $DB_PASS,
            'DB_NAME' => $DB_NAME
        ];

        header("Location: step4.php");
        exit;

    } catch (mysqli_sql_exception $e) {
        $error_message = '❌ Fehler bei der Datenbankverbindung: ' . $e->getMessage();
    }
}
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>nexpell Installation</title>
    <link href="/install/css/bootstrap.min.css" rel="stylesheet">
    <link href="/install/css/installer.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <div class="text-center">
        <img src="/install/images/logo.png" alt="nexpell Logo" class="install-logo mb-4">
        <h2>Schritt 3: Systemüberprüfung & Datenbankverbindung</h2>
    </div>

    <div class="card shadow-sm border-0 mt-4">
        <div class="card-body">

            <h3>Systemüberprüfung</h3>

            <?php foreach ($success_messages as $msg): ?>
                <div class="alert alert-success" role="alert"><?= htmlspecialchars($msg) ?></div>
            <?php endforeach; ?>

            <?php if ($error): ?>
                <div class="alert alert-danger" role="alert"><?= $error ?></div>
            <?php endif; ?>

            <?php if ($error_message): ?>
                <div class="alert alert-danger" role="alert"><?= htmlspecialchars($error_message) ?></div>
            <?php endif; ?>

            <?php if ($requirements_met): ?>
                <hr>
                <h3>Datenbankverbindung einrichten</h3>
                <form method="post">
                    <div class="mb-3">
                        <label class="form-label">Host:</label>
                        <input class="form-control" type="text" name="DB_HOST" value="<?= htmlspecialchars($DB_HOST ?: 'localhost') ?>" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Benutzername:</label>
                        <input class="form-control" type="text" name="DB_USER" value="<?= htmlspecialchars($DB_USER) ?>" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Passwort:</label>
                        <input class="form-control" type="password" name="DB_PASS">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Datenbankname:</label>
                        <input class="form-control" type="text" name="DB_NAME" value="<?= htmlspecialchars($DB_NAME) ?>" required>
                    </div>
                    <div class="mb-3">
                        <input class="btn btn-primary btn-lg w-100" type="submit" value="Weiter zu Schritt 4">
                    </div>
                </form>
            <?php else: ?>
                <p class="text-danger mt-4">❌ Bitte behebe die oben genannten Probleme, um fortzufahren.</p>
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
