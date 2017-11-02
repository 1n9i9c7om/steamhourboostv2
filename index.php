<?php
session_start();
if(empty($_SESSION["userId"])) 
{
    header("Location: login.php");
    die();
}
else
{
    header("Location: ./cp/");
    die();
}

?>