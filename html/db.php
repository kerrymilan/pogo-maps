<?php
/**
 *  Schema overview: 
 *  Filter:             A set of conditions against which each spawn or gym is compared.  Valid
 *                      comparison operators are 'and', and 'or'.  When testing a spawn or gym, 
 *                      a match is declared when one (for 'or' operator) or all (for 'and' 
 *                      operator) of the filter's conditions are met.  
 *  FilterCondition:    An individual key/value pair.  Valid comparison operators are 'eq', 'gte', 
 *                      'lte' and 'not'.  
 *  User:               Consists of a name and a list of filters.
 **/

//  error_reporting(E_ALL); ini_set('display_errors', 1); 
    $sqlPath = "../watch.sqlite"; 

    $handle = new SQLite3($sqlPath);

    class User {
        public $id = -1;
        public $name = "";
        public $filters = [];

        function User($row) {
            $this->id = $row["userid"];
            $this->name = $row["user"];
        }
    }
    
    class Filter {
        public $id = -1;
        public $name = "";
        public $type = "";
        public $operator = "";
        public $conditions = [];
        public $user = null;
        
        function Filter($row, $user) {
            $this->id = $row["filterid"];
            $this->name = $row["filter"];
            $this->type = $row["type"];
            $this->operator = $row["f_operator"];
            $this->user = $user;
        }

        // Make sure the pokemon or gym matches the filter type, then test against each 
        // of this filter's conditions.  
        function Match($r) {
            $ret = false;
            if (($this->type == "pokemons" && array_key_exists("pokemon_id", $r)) ||
                ($this->type == "gyms" && array_key_exists("gym_id", $r))) {
                $first = true;
                foreach ($this->conditions as $c)
                {
                    if ($first) {
                        $ret = $c->Match($r);
                    } else {
                        if ($this->operator == "or") { 
                            $ret = $ret || $c->Match($r);
                        } elseif ($this->operator == "and") {
                            $ret = $ret && $c->Match($r);
                        }
                    }
                    $first = false;
                }
            } else {
                $ret = false;
            }
            return $ret;
        }
    }

    class FilterCondition {
        public $id = -1;
        public $operator = "";
        public $key = "";
        public $value = "";
        public $filter = null;
        
        function FilterCondition($row, $filter) {
            $this->id = $row["conditionid"];
            $this->operator = $row["c_operator"];
            $this->key = $row["key"];
            $this->value = $row["value"];
            $this->filter = $filter;
        }
        
        // Test the specified pokemon or gym against this condition's criteria.
        function Match($r) {
            $k = $this->key;
            if ($this->operator == "eq") {
                return $r->$k == $this->value;
            } elseif ($this->operator == "gte") {
                return (int)$r->$k >= (int)$this->value;
            } elseif ($this->operator == "lte") {
                return (int)$r->$k <= (int)$this->value;
            } elseif ($this->operator == "not") {
                return $r->$k != $this->value;
            } else {
                return false;
            }
        }
    }

    // Return the user associated with the specified ID.  
    function getFilterList($userid) {
        global $handle;
        
        // Lazy implementation: user_filter_list includes all user/filter/condition info
        // in every row rather than executing separate queries for each.  Constructors
        // for each object accept a query result row and pull out the data they care about.
        $q = $handle->prepare("select * from user_filter_list where userid = :id;");
        $q->bindValue(':id', $userid, SQLITE3_INTEGER);
        $rows = $q->execute();

        $u = null;
        $f = null;
        $c = null;

        while ($r = $rows->fetchArray()) {
            // This condition should only be met on the first pass
            if ($u == null) { 
                $u = new User($r);
            }
            
            // This should trigger on the first pass or whenever we've finished parsing 
            // one filter and moved on to the next
            if ($f == null || $f->id != $r["filterid"]) {
                if ($f != null) {
                    // If not first pass, add the filter we've just finished parsing to 
                    // the user's filter list
                    $u->filters[] = $f;
                }
                // (re)initialize the filter
                $f = new Filter($r, $u);
            }
            
            // Add the condition to the current filter
            $f->conditions[] = new FilterCondition($r, $f);
        }
        $u->filters[] = $f;
        return $u;
    }

    // Return a list of all entities hidden by the specified user.  
    // TODO:  periodically purge the 'hidden' table, since entries should have a maximum
    //        functional lifetime of ~1 hour.
    function getHiddenList($userid) {
        global $handle;
        $q = $handle->prepare("select entityid from hidden where userid = :id;");
        $q->bindValue(':id', $userid, SQLITE3_INTEGER);
        $rows = $q->execute();
        $res = [];
        while ($r = $rows->fetchArray()) {
            $res[] = $r["entityid"];
        }
        return $res;
    }
?>
