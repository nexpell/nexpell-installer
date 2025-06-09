<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/check_lock.php';

set_time_limit(300);
ini_set('memory_limit', '512M');

#$updateUrl = "https://update.webspell-rm.de/releases/2.1.7/cms.zip";
$messages = [];





$updateUrl = "https://github.com/Webspell-RM/Webspell-RM-3.0-Next-Generation/archive/refs/heads/main.zip";
$tempZipPath = __DIR__ . "/main.zip";
$extractPath = __DIR__; // /install/
$webrootPath = dirname(__DIR__); // Webroot
$extractedDir = __DIR__ . "/Webspell-RM-3.0-Next-Generation-main";
$messages = [];

function addMessage(&$messages, $message, $type = "info", $icon = "ℹ️") {
    $messages[] = [
        'message' => $message,
        'type' => $type,
        'icon' => $icon
    ];
}

function chmodRecursive($path, $perm = 0777) {
    if (!file_exists($path)) return;
    $iterator = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($path, RecursiveDirectoryIterator::SKIP_DOTS),
        RecursiveIteratorIterator::SELF_FIRST
    );
    foreach ($iterator as $item) {
        chmod($item->getPathname(), $perm);
    }
    chmod($path, $perm);
}

function deleteFolder(string $folder): bool {
    if (!is_dir($folder)) return false;
    $files = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($folder, RecursiveDirectoryIterator::SKIP_DOTS),
        RecursiveIteratorIterator::CHILD_FIRST
    );
    foreach ($files as $file) {
        $filePath = $file->getPathname();
        if ($file->isDir()) {
            rmdir($filePath);
        } else {
            unlink($filePath);
        }
    }
    return rmdir($folder);
}

// Schritt 1: ZIP herunterladen
addMessage($messages, "📥 Lade CMS von GitHub herunter...");
$zipData = @file_get_contents($updateUrl);
if ($zipData === false) {
    addMessage($messages, "❌ Fehler beim Download der ZIP-Datei.", "danger", "❌");
    renderTemplateAndExit($messages);
}
file_put_contents($tempZipPath, $zipData);

// Schritt 2: Entpacken in /install/
$zip = new ZipArchive;
if ($zip->open($tempZipPath) === TRUE) {
    addMessage($messages, "📦 Entpacke CMS...");
    
    // Sicherheitsprüfung
    for ($i = 0; $i < $zip->numFiles; $i++) {
        $entry = $zip->getNameIndex($i);
        if (strpos($entry, '..') !== false) {
            $zip->close();
            unlink($tempZipPath);
            addMessage($messages, "❌ Sicherheitsproblem im ZIP-Archiv (Zip-Slip)", "danger", "⚠️");
            renderTemplateAndExit($messages);
        }
    }

    $zip->extractTo($extractPath);
    $zip->close();
    unlink($tempZipPath);
    addMessage($messages, "✅ ZIP-Datei entpackt.");

    // Schritt 3: Dateien aus extrahiertem Ordner in den Webroot verschieben
    if (is_dir($extractedDir)) {
        $iterator = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($extractedDir, RecursiveDirectoryIterator::SKIP_DOTS),
            RecursiveIteratorIterator::SELF_FIRST
        );

        foreach ($iterator as $item) {
            $sourcePath = $item->getPathname();
            $relativePath = substr($sourcePath, strlen($extractedDir) + 1);
            $targetPath = $webrootPath . '/' . $relativePath;

            if ($item->isDir()) {
                if (!is_dir($targetPath)) {
                    mkdir($targetPath, 0777, true);
                }
            } else {
                if (!copy($sourcePath, $targetPath)) {
                    addMessage($messages, "❌ Fehler beim Kopieren von: $sourcePath", "danger");
                }
            }
        }

        addMessage($messages, "✅ Dateien erfolgreich in den Webroot verschoben.");

        // Schritt 4: Rechte setzen & temporären Ordner löschen
        chmodRecursive($extractedDir);
        if (deleteFolder($extractedDir)) {
            addMessage($messages, "🗑️ Temporärer Ordner gelöscht: $extractedDir");
        } else {
            addMessage($messages, "⚠️ Ordner konnte nicht vollständig gelöscht werden: $extractedDir", "warning");
        }
    } else {
        addMessage($messages, "❌ Fehler: Extrahierter Ordner nicht gefunden: $extractedDir", "danger");
    }

    addMessage($messages, "✅ Update abgeschlossen. Du wirst gleich weitergeleitet...", "success", "✅");
    $redirect = true;

} else {
    addMessage($messages, "❌ Fehler beim Öffnen der ZIP-Datei.", "danger", "❌");
}

renderTemplateAndExit($messages, $redirect ?? false);








// TEMPLATE
function renderTemplateAndExit($messages, $redirect = false) {
    ?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>nexpell Installation</title>
    <link href="/install/css/bootstrap.min.css" rel="stylesheet">
    <link href="/install/css/installer.css" rel="stylesheet">
    <?php if ($redirect): ?>
        <meta http-equiv="refresh" content="5;url=step3.php">
    <?php endif; ?>    
</head>
<body>

<div class="container my-5">
    <div class="text-center">
        <img src="/install/images/logo.png" alt="nexpell Logo" class="install-logo mb-4">
        <h2>Schritt 2: Systemüberprüfung</h2>
    </div>

    <div class="card shadow-sm border-0 mt-4">
        <div class="card-body">
            <h3>nexpell Installer – Schritt 2</h3>

            <?php if (!empty($messages)): ?>
                <?php foreach ($messages as $msg): ?>
                    <div class="alert alert-<?= $msg['type'] ?> d-flex align-items-center" role="alert">
                        <span class="me-2 fs-4"><?= $msg['icon'] ?></span>
                        <div><?= htmlspecialchars($msg['message']) ?></div>
                    </div>
                <?php endforeach; ?>
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
<?php
    exit;
}
