<?php

session_start();

require_once "config.php";

require_once('php/db.php');
require_once('php/AuthController.php');
require_once('php/utilities.php');
require_once('php/Models/Utente.php');
use DB\DBAccess;


// paginate the content
// page structure
$htmlPage = file_get_contents('html/login.html');

$errors = "";

if($_SERVER['REQUEST_METHOD'] == "POST") {     // Pulsante submit premuto
    preventMaliciousCode($_POST);
    $email = $_POST['email'];           // prendo i dati inseriti dall'utente
    $password = $_POST['password'];

    if ($email == '' || $password == ''){
        $errors = "<p class='error'>I campi e-mail e password sono obbligatori!</p>";
    } else {

        $isValid = authentication($email, $password);

        if($isValid){  // utente trovato
            $_SESSION['email'] = $email;
            $_SESSION['userId'] = Utente::getIdFromEmail($email);

        } else if ($isValid === -1){
            header("location: error.php");
        }        
        else {    // utente non registrato o credenziali errate
            $errors = "<div id='errori'><p role='alert' class='response'>
                Le credenziali inserite sono errate, riprova.
            </p></div>";
        }
    }   
}


$footer = file_get_contents("html/components/footer.html");

$htmlPage = str_replace("<pageFooter/>", $footer, $htmlPage);

$htmlPage = str_replace("<formErrors/>", $errors, $htmlPage);

// se l'utente ha già effettuato il login non deve visualizzare questa pagina
if(isset($_SESSION['email']) && $_SESSION['email'] != '') {             
    header("location: areaprivata/profilo.php");
}

//str_replace finale col contenuto specifico della pagina
echo $htmlPage;     // visualizzo la pagina costruita

?>