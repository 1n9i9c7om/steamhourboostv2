<?php
session_start();
if(!empty($_SESSION["userId"])) 
{
    session_destroy();
}

if(isset($_POST["submit"]))
{
    require_once './cp/inc/dbc.inc.php';
    $userId = checkLogin($dbc, $_POST["username"], $_POST["password"]);
    if($userId != 0) 
    {
        $_SESSION["userId"] = $userId;
        header("Location: ./cp/");
    }
    else
    {
        echo "Login failed!";
    }
}
?>

<form method="POST">
<input type="text" name="username" placeholder="Username"> <br/>
<input type="password" name="password" placeholder="Password"> <br/>
<input type="submit" name="submit" value="Login"> 
</form>