<?php

require_once("base.php");

// Parse gym- and raid-specific fields.  See base.php documentation for more information.
// TODO: Fix start-/end-time issues
// Note: gym and raid icons are in ./include/img/raid/.  Use the 'generate.sh' script in that
// folder to regenerate them if required.  This script downloads icons for each team, raid boss,
// and raid level, then overlays them with imagemagick to create an icon for each combination. 
// If raid bosses change, update 'raids.txt' in that folder and regenerate to build the new icons.
class Gym extends Base {

    public $team = "";
    public $moves = "";
    function __construct($r) {
        parent::__construct($r);
        global $moves;

        $fields = "gym_id name team_id slots_available raid_level raid_start raid_end raid_pokemon_move_1 raid_pokemon_move_2 raid_pokemon_name raid_pokemon_id";
        foreach (explode(" ", $fields) as $f) {
            $this->$f = $r[$f];
        }
        $this->id = $this->gym_id . "_" . $this->raid_start;
        $this->type = "gym";

        // Set gym's team name
        $teams = array(0 => "none", 1 => "mystic", 2 => "valor", 3 => "instinct");
        $this->team = $teams[$this->team_id];

        // Set raid start and end time.  Currently not working; off by one hour.  
        $now = new DateTime('@' . time(), new DateTimeZone("America/New_York"));
        $end = new DateTime('@' . $this->raid_end / 1000, new DateTimeZone("America/New_York"));
        $time = $end->format('U') - $now->format('U');
        $this->time = (new DateTime("@$time", new DateTimeZone("America/New_York")))->format("i\ms\s");

        // Set raid boss' moves
        $m1 = (int)$this->raid_pokemon_move_1;
        $m2 = (int)$this->raid_pokemon_move_2;
        if ($m1 != 0 && $m2 != 0) {
            $this->moves = $moves[$m1]["name"] . ", " . $moves[$m2]["name"];
        }
    }
}

?>
