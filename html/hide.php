<?php 
    if (!isset($_COOKIE["user"]) || !isset($_POST["id"])) {
        die();
    } 
    
    require_once("db.php");

    $user = $_COOKIE["user"];
    $id = $_POST["id"];

    // Hide the specified spawn/gym ID for the active user.
    $res = $handle->prepare("insert into hidden(userid, entityid) values (:user, :id);");
    $res->bindValue(':user', $user, SQLITE3_INTEGER);
    $res->bindValue(':id', $id, SQLITE3_TEXT);
    $res->execute();
?>
