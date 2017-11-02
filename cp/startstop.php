<?php
session_start();
if(empty($_SESSION["userId"])) 
{
    header("Location: ../login.php");
    die();
}

if(!isset($_POST["id"]))
{
    die("No ID supplied!");
}

require_once './inc/dbc.inc.php';

if(!doesOwnAccount($dbc, $_SESSION["userId"], $_POST["id"]))
{
    die("Not authorized to manage this account.");
}

if(isset($_POST["action"]))
{
    
    if($_POST["action"] == "start")
    {
        $changeStatusQry = $dbc->prepare("UPDATE SteamAccount SET IsActive = 1 WHERE steamAccount_ID = :accountId");
        $changeStatusQry->bindParam(":accountId", $_POST["id"]);
        $changeStatusQry->execute();

        echo "Started!";
    }
    else if($_POST["action"] == "stop")
    {
        $changeStatusQry = $dbc->prepare("UPDATE SteamAccount SET IsActive = 0 WHERE steamAccount_ID = :accountId");
        $changeStatusQry->bindParam(":accountId", $_POST["id"]);
        $changeStatusQry->execute();

        echo "Stopped!";
    }
    else
    {
        echo "Invalid action";
    }
}