<?php

require_once("moves.php");

// Base class for Gym/Pokemon objects.  Constructor takes in a row from the cached JSON
// content and parses the specified fields.  
class Base {
    public $matches = [];

    public $latitude = -1;
    public $longitude = -1;
    public $lat = -1;
    public $lng = -1;
    public $time = "";
    public $name = "";
    public $link = "";
    public $type = "base";

    function Base($r) {
        $fields = "latitude longitude";
        foreach (explode(" ", $fields) as $f) {
            $this->$f = $r[$f];
        }

        $this->lat = $this->latitude;
        $this->lng = $this->longitude;

        $this->link = $this->Link();
    }

    // Compare this object's content against a list of filters.  Return true if 
    // one or more filters returns a match.  
    function Match($filters)
    {
        
        $this->matches = [];
        foreach ($filters as $f) {
            if ($f->Match($this)) {
                $this->matches[] = $f->name;
            }
        }
        
        return (count($this->matches) != 0);
    }

    // Return a link to this object's coordinates on Google Maps.
    function Link() {
        if ($this->latitude != "" && $this->longitude != "") {
            return "http://maps.google.com/maps?q=" . $this->latitude . "," . $this->longitude;
        } else {
            return "";
        }
    }

    // Return this object's fields in JSON format.  
    function Json() {
        return json_encode($this);
    }
}

?>
