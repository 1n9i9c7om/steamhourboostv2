<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<?php
session_start();
if(empty($_SESSION["userId"])) 
{
    header("Location: ../login.php");
    die();
}

require_once './inc/dbc.inc.php';

$accounts = getOwnedAccounts($dbc, $_SESSION["userId"]);

foreach($accounts as $account)
{
    echo '<a href="#" onClick="loadAccountData(' . $account["steamAccount_ID"] . ');">' . htmlspecialchars($account["username"]) . "</a> <br/>"; 
}

?>

<div id="accountInfo"></div>

<script>
function loadAccountData(id)
{
    $.post( "account.php", { id: id })
    .done(function( data ) {
        $("#accountInfo").html(data);
    });
}
</script>