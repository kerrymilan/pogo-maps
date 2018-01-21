<html>
    <head>
        <title>Select filters</title>
        <script type="text/javascript" src="include/js/jquery-3.2.0.min.js"></script>
        <link rel="stylesheet" href="include/css/style.css" type="text/css" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" />
    </head>
    <body>
        <?php
            // Prompt the user to select a profile from watch.sqlite's user list, then set a
            // cookie containing that user's ID. No authentication since we're not doing 
            // anything sensitive; the worst a malicious user could do is select or deselect 
            // a given user's filters.  
            if (isset($_COOKIE["user"])) {
                header("Location: index.php");
            } elseif (isset($_GET["user"])) {
                setcookie("user", $_GET["user"]) && header("Location: index.php");
            } else {
                require_once("db.php");
                $req = $handle->query("select * from user;");
                while ($r = $req->fetchArray()) {
                    echo ("<div class='user'><a class='user' href='user-select.php?user=" . $r["id"] . "'>" . $r["name"] . "</a></div>");
                }
            }
        ?>
    </body>
</html>
