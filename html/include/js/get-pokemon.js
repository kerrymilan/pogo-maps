function initSort() {
    $("table#encounter").addSortWidget(null, 1, false);
}

function showDistance(position) {
    curLat = position.coords.latitude;
    curLng = position.coords.longitude;
    $("a.dir-link").each(function() {
        lat2 = parseFloat($(this).attr("lat"));
        lng2 = parseFloat($(this).attr("lng"));
        dist = Math.round(calcDistance(curLat, curLng, lat2, lng2) * 0.6 * 10) / 10;
        $(this).text(dist + " mi");
    });
}

function calcDistance(lat1, lng1, lat2, lng2)
{    
    R = 6371; // km
    dLat = toRad(lat2 - lat1);
    dLon = toRad(lng2 - lng1);
    lat1 = toRad(lat1);
    lat2 = toRad(lat2);

    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
    d = R * c;
    return d;
}

function toRad(Value) 
{
    return Value * Math.PI / 180;
}

function hideRow(id)
{
    row = $("tr[rel='" + id + "']");
    row.remove();
    c = Cookies.get("hiddenRows");
    c += "," + id;
    Cookies.set("hiddenRows", c);
}

function getHiddenRows() 
{
    c = Cookies.get("hiddenRows");
    if (c)
    {
        c2 = c.split(",");

        for (x = 0; x < c2.length; x++)
        {
            $("tr[rel='" + c2[x] + "']").css("display", "none");
        }
        $("#restore-hidden").show();
    }
}

function restoreHidden()
{
    Cookies.set("hiddenRows", "");
    refreshTable();
    $("#restore-hidden").hide();
}

function initTable()
{
    getHiddenRows();
    updateDistance();
    $("div.close-icon").click(function() { hideRow($(this).parents("tr").attr("rel")); $("#restore-hidden").show(); });
    initSort();
}

function refreshTable(raid=false)
{
    $("#table-container").html("");
    if (raid) {
        page = "get-raid.php";
    } else {
        page = "get-pokemon.php";
    }
    $.get(page, function(data) 
    { 
        $("#table-container").html(data); 
        initTable();
    
    });
}

function updateDistance()
{
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showDistance);
    } else {
        console.log("Could not initialize geolocation");
    }
}

