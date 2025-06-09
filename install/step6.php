<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();

    // installed.lock schreiben
$lock_file = __DIR__ . '/../system/installed.lock';
file_put_contents($lock_file, "Installation erfolgreich am " . date('Y-m-d H:i:s'));
}
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schritt 5: Installation abgeschlossen</title>
    <link href="/install/css/bootstrap.min.css" rel="stylesheet">
    <link href="/install/css/installer.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <div class="text-center">
        <img src="/install/images/logo.png" alt="nexpell Logo" class="install-logo mb-4">
        <h2>Installation abgeschlossen</h2>
    </div>

    <div class="card shadow-sm border-0 mt-4">
        <div class="card-body text-center">
        <h3 class="text-start">Installation abgeschlossen</h3>
<p class="text-start">nexpell wurde erfolgreich installiert und ist nun bereit zur Nutzung.</p>

<div class="alert alert-warning mt-3">
    ⚠️ <strong>Sicherheits-Hinweis:</strong><br>
    Aus Sicherheitsgründen solltest du jetzt den Ordner <code>/install/</code> löschen oder umbenennen.<br>
    Solange dieser Ordner existiert, könnte ein unbefugter Zugriff auf das Installationsskript erfolgen und deine Installation gefährden.
</div>

<p class="mt-3">Du kannst dich nun mit deinem Administrator-Konto im Backend anmelden und dein System konfigurieren.</p>



        <br>

        <a class="btn btn-primary" href="../index.php" class="btn">Zur Startseite</a>
        <a class="btn btn-primary" href="../admin/login.php" class="btn">Zum Admin-Login</a>
    </div>
    

    <div class="card-footer text-center text-muted small">
                            &copy; <?= date("Y") ?> nexpell Installer
                        </div>
</div>

<script src="/install/js/bootstrap.bundle.min.js"></script>
</body>
</html>