<?php 
    // TODO: Add your Google Maps API key to the URL below

    // Make sure a user is selected, then create a canvas and initialize the map.
    if (!isset($_COOKIE["user"])) {
        header("Location: user-select.php");
    }

    require_once("db.php"); 
    require_once("pokemon.php");
    require_once("gym.php");
?>

<html>
    <head>
        <link rel="stylesheet" href="include/css/style.css" type="text/css" />
        <script type="text/javascript" src="include/js/jquery-3.2.0.min.js"></script>
        <script type="text/javascript" src="include/js/js-cookie.js"></script>
        <script type="text/javascript" src="include/js/sorttable.js"></script>
        <script type="text/javascript" src="include/js/get-pokemon.js"></script> 
        <script type="text/javascript" src="include/js/map.js"></script> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" />
        <title>Pokemon Go Tracker</title>
    </head>
    <body>
        <div id="map" style="height: 100%;"></div>
        <div id="button-container"></div>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=GOOGLE_MAPS_API_KEY&callback=initMap"></script>
        <style type="text/css"> .highIV { color: red; } </style>
    </body>
</html>
