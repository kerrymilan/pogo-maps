var markerBase = "https://maps.google.com/mapfiles/ms/icons/";
var pokeImage = "https://pogo.kerrymilan.com/include/img/icons-sprite2.png";
var latlngbounds, pinImage, marker, map;

function initMap() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(geoCallback);
    } else {
        console.log("Could not initialize geolocation");
    }
}

function setHome(pos) {
    pinImage = new google.maps.MarkerImage(markerBase + "purple-dot.png");
    latlngbounds = new google.maps.LatLngBounds();
    map = new google.maps.Map( document.getElementById('map'), { zoom: 12, center: pos } );
    marker = new google.maps.Marker( {  map: map, position: pos, icon: pinImage } );
    latlngbounds.extend(pos);

    var filters = $("<a href='filter-select.php'><div class='button' id='filters'>Filters</div></a>");
    var refresh = $("<div class='button' id='refresh'><img src='../include/img/refresh.png' /></div>");
    $("#button-container").remove();
    $("<div id='button-container' />").appendTo("body");
    $("#button-container").append(filters).append(refresh);
    map.controls[google.maps.ControlPosition.BOTTOM_RIGHT].push(document.getElementById('button-container'));
    $("#refresh").click( function(e) { initMap(); } );
}

function geoCallback(res) {
    pos = { lat: res.coords.latitude, lng: res.coords.longitude };
    setHome(pos);
    getWatched();
}

function getWatched() {
    console.log("calling getJSON()");
    $.getJSON("watched.php", function(data) {
        console.log("getJSON callback");
        var nearby = false;
        data.forEach( function(i) {
            var x = ((i.pokemon_id - 1) % 28) * 40;
            var y = Math.floor((i.pokemon_id - 1) / 28) * 40;
            var markerImg;
            if (i.type == "pokemon") {
                markerImg = {
                    url: pokeImage,
                    size: new google.maps.Size(40, 40),
                    origin: new google.maps.Point(x, y),
                    anchor: null, 
                    scaledSize: new google.maps.Size(1120, 720)
                };
            } else if (i.type == "gym") {
                if (i.raid_pokemon_id) {
                    var raidImg = "include/img/raid/" + i.team + "_r" + i.raid_pokemon_id + ".png";
                    markerImg = {
                        url: raidImg,
                        size: new google.maps.Size(64, 64),
                        scaledSize: new google.maps.Size(64, 64)
                    };
                } else {
                    var raidImg = "include/img/raid/" + i.team + "_" + i.raid_level + ".png";
                    markerImg = {
                        url: raidImg,
                        size: new google.maps.Size(64, 64),
                        scaledSize: new google.maps.Size(64, 64)
                    };
                }
            }
                    
            
            
            var highIV = false;
            var animation = null;
            if (i.ivs == 100) {
                animation = google.maps.Animation.BOUNCE;
                highIV = true;
            }

            var m = new google.maps.Marker( { map: map, position: i, icon: markerImg, animation: animation } ); 

            google.maps.event.addListener(m, "click", function(e) {
                m.setAnimation(null);
                var directionsService = new google.maps.DirectionsService();
                var request = { destination: i, origin: pos, travelMode: "DRIVING" };
                var time = "";
                var addr = "";

                directionsService.route(request, function(response, status) {
                    if (status == "OK") {
                        var route = response.routes[0].legs[0];
                        time = route.duration.text;
                        addr = "<a target='_blank' href='" + i.link + "'>" + route.end_address.replace(", USA", "").replace(" 24018", "") + "</a>";
                        
                        desc = getLabelText(i);
                        desc += "<strong>Travel time: </strong>" + time + "<br />";
                        desc += "<strong>Location: </strong>" + addr;
                        
                        desc += "<br /><br />";

                        var hide = "<a class='hide' rel='" + i.id + "' href='#'>Hide</a>";
                        desc += hide;
                        infoWindow.setContent(desc);
                        infoWindow.open(map, m);
                        
                        $(".hide").click( function() {
                            var id = $(this).attr("rel");
                            $.post("hide.php", { id: id }, function(data) { 
                                m.setMap(null);
                            });
                        });
                    }
                });
            });

            if (highIV || calcDistance(pos.lat, pos.lng, i.lat, i.lng) <= 2) {
                nearby = true;
                latlngbounds.extend(i);
            }
        });

        infoWindow = new google.maps.InfoWindow();
        
        map.setCenter(latlngbounds.getCenter());

        if (! nearby) {
            map.setZoom(16);
        } else {
            map.fitBounds(latlngbounds);
        }
    });

}

function getLabelText(i) {
    var desc = "<strong>" + i.name + "</strong><br /><br />";

    if (i.type == "pokemon") {
        desc += "<strong>Level: </strong>" + i.level + ", <strong>CP: </strong>" + i.cp;
        if (i.ivs > 0) {
            desc += ", <strong>IVs: </strong>" + Math.round(i.ivs, 2) + "% ";
            desc += " (" + i.individual_attack + " / " + i.individual_defense + " / " + i.individual_stamina + ")";
        }
        desc += "<br />";
    }

    if (i.moves.replace(",", "").replace(" ", "") != "") {
        desc += "<strong>Moves: </strong>" + i.moves + "<br />";
    }

    desc += "<strong>Time remaining: </strong>" + i.time + "<br />";
    desc += "<br />";
    
    desc += "<strong>Matched rules: </strong>" + i.matches + "<br />";

    desc += "<br />";
    return desc;
}
