<?php
session_start();
if(empty($_SESSION["userId"])) 
{
    header("Location: ../login.php");
    die();
}

require_once './inc/dbc.inc.php';
require_once './inc/SteamTotp.php'; // if you're using composer
use SteamTotp\SteamTotp;

if(!isset($_POST["id"]))
{
    die("No ID supplied!");
}

if(!doesOwnAccount($dbc, $_SESSION["userId"], $_POST["id"]))
{
    die("Not authorized to manage this account.");
}

$account = getAccount($dbc, $_POST["id"]);

?>

User: <?= $account["username"]; ?> <br/>
Pass: <?= getPassword($dbc, $_SESSION["userId"], $_POST["id"]); ?> <br/>
<?php 
$secret = getSecret($dbc, $_SESSION["userId"], $_POST["id"]);
if($secret != "")
{
    echo "Code: " . SteamTotp::getAuthCode($secret) . "<br/>";
}
?>
IsActive: <?= $account["IsActive"]; ?> <br/>
<br/>

<button onClick="changeAccountStatus(<?= htmlspecialchars($_POST["id"])?>, 'start')">Start</button>
<button onClick="changeAccountStatus(<?= htmlspecialchars($_POST["id"])?>, 'stop')">Stop</button>


<div id="statusChangeMsg"></div>

<script>
function changeAccountStatus(id, action)
{
    $.post( "startstop.php", { id: id, action: action })
    .done(function( data ) {
        $("#statusChangeMsg").html(data);
    });
}
</script>