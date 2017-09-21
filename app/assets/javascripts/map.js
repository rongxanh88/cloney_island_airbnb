$(document).on("ready", function() {
  L.mapbox.accessToken = gon.mapbox_api_key;
  var map = L.mapbox.map('map', 'mapbox.run-bike-hike', { zoomControl: false }).setView([39.739, -104.990], 12);
  var myLayer = L.mapbox.featureLayer().addTo(map);

  myLayer.on("layeradd", function(e){
    var marker = e.layer;
    var properties = marker.feature.properties;
    var popupContent = '<div class="marker-popup">' + '<h3>' + properties.name + '</h3>' +
      '<h4>' + properties.address + '</h4>' + '</div>';
    map.fitBounds(myLayer.getBounds());
    return marker.bindPopup(popupContent, {closeButton: false, minWidth: 300});
  });

  $(document).on('click', '.search-submit', function(){
    var address = document.getElementsByClassName('search-address')[0].value
    $.ajax({
      dataType: "text",
      url: "/listings.json",
      data: {search_address: address},
      success:function(data) {
        var geojson = $.parseJSON(data);
        sessionStorage.setItem('setting', JSON.stringify(geojson));
        myLayer.setGeoJSON({
          type: "FeatureCollection",
          features: $.parseJSON(sessionStorage.getItem('setting'))
        });
      },
      error:function(error) {
        alert("Could not load the listings");
      }
    });
  });
});
