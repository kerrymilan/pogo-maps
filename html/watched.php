<?php 
    // Read the cached tracker data and check each pokemon and gym against the active
    // user's filters and list of hidden objects.  Output all matched rows in JSON format.  
    require_once("db.php"); 
    require_once("pokemon.php");
    require_once("gym.php");

    $out = json_decode(file_get_contents("/opt/pogo-maps/out/current"), true);

    $user = $_COOKIE["user"];
    if ($user == null) $user = 1;
    $u = getFilterList($user);
    $h = getHiddenList($user);

    $matches = [];

    foreach ($out["pokemons"] as $p) {
        $poke = new Pokemon($p);
        if ((!in_array($poke->id, $h)) && $poke->Match($u->filters)) {
            $matches[] = $poke;
        }
    }

    foreach ($out["gyms"] as $g) {
        $gym = new Gym($g);
        if ($gym->Match($u->filters)) {
            $matches[] = $gym;
        }
    }

    echo json_encode($matches);
?>
