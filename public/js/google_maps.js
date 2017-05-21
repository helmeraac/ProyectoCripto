
// GOOGLE MAP
	function initialize($) {
		var initialPos = {lat: 4.602087, lng: -74.072421};
		document.getElementById("latitude").value = initialPos.lat;
		document.getElementById("longitude").value = initialPos.lng;
		var mapOptions = {	
				zoom: 12,
				center: initialPos,
				scrollwheel: false
		};
		var map = new google.maps.Map(document.querySelector('.map'), mapOptions);
		var geocoder = new google.maps.Geocoder();

		var marker = new google.maps.Marker({
			position: initialPos,
			map: map,
			draggable: true  
		});

		geocoder.geocode({'location': initialPos}, function(results, status) {
				if (status === 'OK') {
					if (results[0]) {
					document.getElementById("address").value = results[0].formatted_address;
					} else {
					document.getElementById("address").value ='No results found';
					}
				}
			});

		google.maps.event.addListener(marker, 'dragend', function(evt){
				var latlng = evt.latLng;

				document.getElementById("latitude").value = evt.latLng.lat();
				document.getElementById("longitude").value = evt.latLng.lng();

				geocoder.geocode({'location': latlng}, function(results, status) {
					if (status === 'OK') {
						if (results[0]) {
						document.getElementById("address").value = results[0].formatted_address;
						} else {
						document.getElementById("address").value ='No results found';
						}
					}
				});
			});

		if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {

            var pos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };

			document.getElementById("latitude").value = position.coords.latitude;
			document.getElementById("longitude").value = position.coords.longitude;

			marker.setPosition(pos);
			map.setZoom(16);
            map.setCenter(pos);

			geocoder.geocode({'location': pos}, function(results, status) {
				if (status === 'OK') {
					if (results[0]) {
					document.getElementById("address").value = results[0].formatted_address;
					} else {
					document.getElementById("address").value ='No results found';
					}
				}
			});
          });
        }
	}
	google.maps.event.addDomListener(window, 'load', initialize);