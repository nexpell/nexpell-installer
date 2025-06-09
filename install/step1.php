<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/check_lock.php';

// Wenn der Benutzer das Formular abgesendet hat
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Überprüfen, ob die Checkbox angekreuzt wurde
    if (isset($_POST['accept_license']) && $_POST['accept_license'] == '1') {
        $_SESSION['license_accepted'] = true;
        header("Location: step2.php");  // Weiterleitung zur nächsten Installationsseite
        exit;
    } else {
        $error = "❌ Du musst die Lizenzbedingungen akzeptieren, um fortzufahren.";
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
        <h2>Schritt 1: Lizenzbedingungen</h2>
    </div>

    <div class="card shadow-sm border-0 mt-4">
        <div class="card-body">
            <h3>Lizenzbedingungen - Schritt 1</h3>
            <?php if (isset($error)): ?>
                <div class="alert alert-danger"><?= htmlspecialchars($error) ?></div>
            <?php endif; ?>

            <div class="alert alert-info">
                <h4 class="alert-heading">GNU General Public License (GPL)</h4>
                <p>nexpell ist freie Software, lizenziert unter der GNU GPL v3.</p>
                <p>Du darfst den Code frei nutzen, verändern und verbreiten, solange du die Lizenzbedingungen einhältst.</p>
                <p><a href="https://www.gnu.org/licenses/gpl-3.0.html" target="_blank" rel="noopener">Lizenz anzeigen (externer Link)</a></p>
            </div>

            <form method="post" class="mt-4">
                <div class="form-check">
                    <input type="checkbox" name="accept_license" value="1" class="form-check-input" id="accept_license" required>
                    <label class="form-check-label" for="accept_license">
                        Ich habe die Lizenz gelesen und akzeptiere sie.
                    </label>
                </div>
                <button type="submit" class="btn btn-primary mt-3">Weiter zur Installation</button>
            </form>

        </div>
        <div class="card-footer text-center text-muted small">
                            &copy; <?= date("Y") ?> nexpell Installer
                        </div>
    </div>
</div>

                        <script src="/install/js/bootstrap.bundle.min.js"></script>
</body>
</html>
