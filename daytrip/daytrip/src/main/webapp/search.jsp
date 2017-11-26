<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF8">
  <title>Day Trip</title>
  <!-- 套件CSS -->
  <link href="package/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" media="screen">
  <link href="package/bootstrap/dist/css/bootstrap.css" rel="stylesheet" media="screen">
  <!-- 套件JS -->
  <script src="js/jquery-3.2.1.js"></script>
  <script src="package/bootstrap/assets/js/vendor/popper.min.js"></script>
  <script src="package/bootstrap/dist/js/bootstrap.min.js"></script>
  <script src="package/bootstrap/dist/js/bootstrap.js"></script>
  <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfU3lA88R45G_p3OLnzA5xYxos-blGCww&sensor=false&libraries=places&callback=initMap" type="text/javascript"></script>
  <script async defer src="https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyCfU3lA88R45G_p3OLnzA5xYxos-blGCww" type="text/javascript"></script>
  <!-- 自加CSS -->
  <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      
      .map-control {
        background-color: #fff;
        border: 1px solid #ccc;
        box-shadow: 0 2px 2px rgba(33, 33, 33, 0.4);
        font-family: 'Roboto','sans-serif';
        margin: 10px;
        position: absolute;
        left: 10%;
        z-index: 1;
      }
      
      .selector-control {
        font-size: 14px;
        line-height: 30px;
        padding-left: 5px;
        padding-right: 5px;
      }
    </style>
  </head>
<body>
  <div id="map">
  </div>
  <script>
  	  var map;
  	  
	  function initMap() {
		  
		map = new google.maps.Map(document.getElementById('map'), {
		    center: {lat: 24.7994476, lng: 120.9790206},
		    zoom: 12
	    });
	
	    // Try HTML5 geolocation.
	    if (navigator.geolocation) {
	      navigator.geolocation.getCurrentPosition(function(position) {
	    	  
	    	var pos = {
	          lat: 24.7994476,
	          lng: 120.9790206
	        };

	        map.setCenter(pos);	        
	        
	        $.ajax({
	         	type: "POST",
	         	url: "function/hsinchu.jsp", 
	         	data: {
	         		positionlatitude:  24.7994476,
             		positionlongitude: 120.9790206
	          	},
	         	success: function(response){
	        		  var obj = JSON.parse(response);
	        		  var infowindow = null;
	        		  
	        		  for(var i=0; i < obj.length ; i++){
	        			  //alert(obj[i].id);
	        			 var marker = new google.maps.Marker({
	        			    position: {lat: obj[i].lat, lng: obj[i].lng},
	        			    map: map,
	        			    icon: "images/"+obj[i].image,
	        			    content: obj[i].station
	        			 });
	        			 
	        			google.maps.event.addListener(marker, 'click', (function(marker, i) {
		       		     	 return function() {
		       		     		if (infowindow) {
		       		     	        infowindow.close();
		       		     	    }
		       		     		infowindow = new google.maps.InfoWindow({
		       	       			    content:  
		       	       			    	"站名: " +  obj[i].station + "<br>" +
		       	       			    	"地址: " + obj[i].address + "<br>" +   
		       	       			    	"場站總停車格: " + obj[i].total
		       	       			 });
		         			    map.setCenter(marker.getPosition());
		       		            infowindow.open(map, marker);
		       		       	}      		     
	       		     	})(marker, i));
	        			 
	        			 /*
	        			 kmradius = (parseFloat(1) / 6378.1) *6378100
	        			 var cityCircle = new google.maps.Circle({
        		            center: marker.getPosition(),
        		            clickable: true,
        		            draggable: false,
        		            editable: false,
        		            fillColor: '#004de8',
        		            fillOpacity: 0.27,
        		            map: map,
        		            radius: kmradius,
        		            strokeColor: '#004de8',
        		            strokeOpacity: 0.62,
        		            strokeWeight: 1
        		          });
	        			 */
	        			        			 
	        		 }
	             },
	             error: function(xhr, ajaxOptions, thrownError)
	             { 
	               alert(xhr.status); 
	               alert(thrownError.Error); 
	             }
	         });
	        
	        $.ajax({
	         	type: "POST",
	         	url: "function/hot.jsp", 
	         	data: {
	         		positionlatitude:  24.7994476,
             		positionlongitude: 120.9790206
	          	},
	         	success: function(response){
	        		  var obj = JSON.parse(response);
	        		  var infowindow = null;
	        		  
	        		  for(var i=0; i < obj.length ; i++){
	        			  //alert(obj[i].id);
	        			 var marker = new google.maps.Marker({
	        			    position: {lat: obj[i].lat, lng: obj[i].lng},
	        			    map: map,
	        			    content: obj[i].station
	        			 });
	        			 
	        			google.maps.event.addListener(marker, 'click', (function(marker, i) {
		       		     	 return function() {
		
		       		     		infowindow = new google.maps.InfoWindow({
		       	       			    content:  
		       	       			    	"站名: " +  obj[i].station + "<br>"
		       	       			 });
		         			    map.setCenter(marker.getPosition());
		       		            infowindow.open(map, marker);
		       		       	}      		     
	       		     	})(marker, i));
	        			 
	        			 
	        			 kmradius = (parseFloat(0.5) / 6378.1) *6378100
	        			 var cityCircle = new google.maps.Circle({
        		            center: marker.getPosition(),
        		            clickable: true,
        		            draggable: false,
        		            editable: false,
        		            fillColor: '#004de8',
        		            fillOpacity: 0.27,
        		            map: map,
        		            radius: kmradius,
        		            strokeColor: '#004de8',
        		            strokeOpacity: 0.62,
        		            strokeWeight: 1
        		         });
	        			 
	        			        			 
	        		 }
	             },
	             error: function(xhr, ajaxOptions, thrownError)
	             { 
	               alert(xhr.status); 
	               alert(thrownError.Error); 
	             }
	         });
	        
	      }, function() {
	        handleLocationError(true, infoWindow, map.getCenter());
	      });
	    } else {
	      // Browser doesn't support Geolocation
	      handleLocationError(false, infoWindow, map.getCenter());
	    }
	  }
	
	  function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	    infoWindow.setPosition(pos);
	    infoWindow.setContent(browserHasGeolocation ?
	                          'Error: The Geolocation service failed.' :
	                          'Error: Your browser doesn\'t support geolocation.');
	  }
  </script>
</body>
</html>