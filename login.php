<?php

require_once('php/db.php');
require_once('php/AuthController.php');
use DB\DBAccess;

session_start();

// paginate the content
// page structure
$htmlPage = file_get_contents('html/login.html');

$errors = "";

if($_SERVER['REQUEST_METHOD'] == "POST") {     // Pulsante submit premuto
    $email = $_POST['email'];           // prendo i dati inseriti dall'utente
    $password = $_POST['password'];

    if ($email == '' || $password == ''){
        $errors = "<p class='error'>E-mail and Password fields are required!</p>";
    } else {

        $isValid = authentication($email, $password);

        if($isValid){  // utente trovato
            $_SESSION['email'] = $email;

        } else {    // utente non registrato o credenziali errate
            $errors = "<p class='error'>
                Your credentials are wrong!
            </p>";
        }
    }   
}

$htmlPage = str_replace("<formErrors/>", $errors, $htmlPage);

// se l'utente ha già effettuato il login non deve visualizzare questa pagina
if(isset($_SESSION['email']) && $_SESSION['email'] != '') {             
    header("location: profile.php");
}

//str_replace finale col conenuto specifico della pagina
echo $htmlPage;     // visualizzo la pagina costruita

?>