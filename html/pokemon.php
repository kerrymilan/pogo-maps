<?php
require_once("base.php");
require_once("coords.php");

// Parse pokemon-specific fields.  See base.php documentation for more information.
class Pokemon extends Base {
    public $pokemon_id = -1;
    public $pokemon_name = "";

    public $encounter_id = -1;
    public $disappear_time = -1;

    public $move_1 = -1;
    public $move_2 = -1;
    public $individual_attack = -1;
    public $individual_defense = -1;
    public $individual_stamina = -1;

    public $cp = -1;
    public $level = -1;

    public $ivs = -1;
    public $moves = "";
    public $pos = [];

    function __construct($r) {
        parent::__construct($r);

        global $moves;
        global $coords;

        $fields = "pokemon_id pokemon_name encounter_id disappear_time cp level move_1 move_2 individual_attack individual_defense individual_stamina";
        foreach (explode(" ", $fields) as $f) {
            $this->$f = $r[$f];
        }

        // Calculate IV %
        $this->ivs = round( 
                        $this->individual_attack + 
                        $this->individual_defense + 
                        $this->individual_stamina 
                     ) * 100 / 45;

        // Determine time until despawn in minutes and seconds
        $now = (new DateTime())->format("U");
        $time = ($this->disappear_time / 1000) - $now;
        $this->time = (new DateTime("@$time"))->format("i\ms\s");

        // Convert move IDs to move names
        $m1 = (int)$this->move_1;
        $m2 = (int)$this->move_2;
        if ($m1 != 0 && $m2 != 0) {
            $this->moves = $moves[$m1]["name"] . ", " . $moves[$m2]["name"];
        }

        $this->pos = $coords[(int)$this->pokemon_id];
        $this->name = "$this->pokemon_name (#$this->pokemon_id)";
        $this->id = $this->encounter_id;
        $this->type = "pokemon";

    }
}
