<?php
    // Delete the filter from the active user's watch list
    if (!isset($_COOKIE["user"])) {
        header("Location: user-select.php");
    }
    if (!isset($_POST["id"])) {
        echo "No ID parameter specified";
        die();
    }
    require_once("db.php");

    $user = $_COOKIE["user"];
    $id = $_POST["id"];

    $req = $handle->prepare("delete from user_filter where userid = :user and id = :id");
    $req->bindValue(':user', $user, SQLITE3_INTEGER);
    $req->bindValue(':id', $id, SQLITE3_INTEGER);
    $req->execute();
?>
