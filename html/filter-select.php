<html>
    <head>
        <title>Select filters</title>
        <script type="text/javascript" src="include/js/jquery-3.2.0.min.js"></script>
        <link rel="stylesheet" href="include/css/style.css" type="text/css" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" />
    </head>
    <body>
        <a href='index.php'>&laquo; Back</a>
        <br />
        <br />
        <?php
            // Retrieve and display the list of filters.  If the active user has selected a filter, 
            // populate the 'uf_id' field.  When a user checks a box on this page, pass the filter's
            // ID to 'add-filter.php'; when the user unchecks a box, pass the uf_id (user_filter ID) 
            // to 'del-filter.php'.  All calls are made via jquery $.post() so there's no need to 
            // save when finished.
            if (!isset($_COOKIE["user"])) {
                header("Location: user-select.php");
            }
            $u = $_COOKIE["user"];

            require_once("db.php");

            $query = $handle->prepare("select f.*, uf.id as uf_id from filter f left join (select * from user_filter where userid = :user) uf on f.id = uf.filterid order by sortorder, f.name;");
            $query->bindValue(':user', $u, SQLITE3_INTEGER);
            $res = $query->execute();
            while ($r = $res->fetchArray()) {
                $id = $r["id"];
                $name = $r["name"];
                $ufid = $r["uf_id"];
                
                $c = "";
                if ($ufid != "") $c = " checked='checked'"; 
                echo "<input type='checkbox' id='filter$id' f_id='$id' uf_id='$ufid' $c />";
                echo "<label for='filter$id'>$name</label><br />";
            }
        ?>
        <br />
        <a href='index.php'>&laquo; Back</a>
        <script type="text/javascript">
            $().ready( function() {
                $("input").click( function(e) {
                    var c = $(this).prop("checked");
                    var id, url;

                    if (c) {
                        id = $(this).attr("f_id");
                        url = "add-filter.php";
                    } else {
                        id = $(this).attr("uf_id");
                        url = "del-filter.php";
                    }
                    console.log(id);
                    $.post(url, { id: id }, function(d) { console.log(d); });
                });
            });
        </script>
    </body>
</html>
