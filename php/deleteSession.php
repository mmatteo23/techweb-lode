<?php
    require_once('Models/Sessione.php');   

    Sessione::delete($_POST['sessione']);
?>