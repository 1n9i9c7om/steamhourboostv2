<?php
$dbc = new PDO('mysql:host=localhost;dbname=steamboost', 'steamboost', '**********');
$dbc->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_SILENT);
$dbc->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

function checkLogin($dbc, $username, $password)
{
    $getPasswordHashQuery = $dbc->prepare("SELECT password, user_id FROM User WHERE username = :username");
    $getPasswordHashQuery->bindParam(":username", $username);
    $getPasswordHashQuery->execute();

    $row = $getPasswordHashQuery->fetch();

    if (password_verify($password, $row["password"])) {
        return $row["user_id"];
    } else {
        return 0;
    }
}

function getOwnedAccounts($dbc, $userId)
{
    $getOwnedAccountsQry = $dbc->prepare("SELECT * FROM AccountUser, SteamAccount WHERE SteamAccount_NR = steamAccount_ID AND User_NR = :user");
    $getOwnedAccountsQry->bindParam(":steamAcc", $accountId);
    $getOwnedAccountsQry->bindParam(":user", $userId);
    $getOwnedAccountsQry->execute();

    return $getOwnedAccountsQry->fetchAll();
}

function doesOwnAccount($dbc,$userId, $accountId, $canViewLoginDataCheck = false)
{
    $qry = "SELECT COUNT(*) FROM AccountUser WHERE SteamAccount_NR = :steamAcc AND User_NR = :user";
    if($canViewLoginDataCheck) $qry .= " AND canWeLoginData = 1";

    $doesOwnAccQry = $dbc->prepare($qry);
    $doesOwnAccQry->bindParam(":steamAcc", $accountId);
    $doesOwnAccQry->bindParam(":user", $userId);
    $doesOwnAccQry->execute();

    return ($doesOwnAccQry->fetchColumn() > 0); // if, for some reason, the user/account combination is added twice, it should still return true
}

function getPassword($dbc,$userId, $accountId)
{
    if(doesOwnAccount($dbc, $userId, $accountId, true))
    {
        $getPasswordQry = $dbc->prepare("SELECT password FROM SteamAccount WHERE steamAccount_ID = :accountId LIMIT 1");
        $getPasswordQry->bindParam(":accountId", $accountId);
        $getPasswordQry->execute();

        return $getPasswordQry->fetchColumn();
    }
    else
    {
        return "No permission";
    }
}

function getSecret($dbc, $userId, $accountId)
{
    if(doesOwnAccount($dbc, $userId, $accountId, true))
    {
        $getPasswordQry = $dbc->prepare("SELECT secret FROM SteamAccount WHERE steamAccount_ID = :accountId LIMIT 1");
        $getPasswordQry->bindParam(":accountId", $accountId);
        $getPasswordQry->execute();

        return $getPasswordQry->fetchColumn();
    }
    else
    {
        return "0";
    }
}

function getAccount($dbc, $accountId)
{
    $getAccountsQry = $dbc->prepare("SELECT * FROM SteamAccount WHERE steamAccount_ID = :steamAcc");
    $getAccountsQry->bindParam(":steamAcc", $accountId);
    $getAccountsQry->execute();

    return $getAccountsQry->fetch();
}


?>