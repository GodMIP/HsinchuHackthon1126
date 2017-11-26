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
      
      .controls {
        margin-top: 10px;
        border: 1px solid transparent;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        height: 32px;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
      }

      #pac-input {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 0px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 300px;
      }

      #pac-input:focus {
        border-color: #4d90fe;
      }
      
      #pac-output {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 300px;
      }

      #pac-output:focus {
        border-color: #4d90fe;
      }
      
      #pac-button {
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
      }

      .pac-container {
        font-family: Roboto;
      }

      #type-selector {
        color: #fff;
        background-color: #4d90fe;
        padding: 5px 11px 0px 11px;
      }

      #type-selector label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
      }
      
      #target {
        width: 345px;
      }
      
      #floating-panel {
        position: absolute;
	    top: 8%;
	    left: 9%;
	    z-index: 1;
	    background-color: #fff;
	    padding: 5px;
	    border: 1px solid #999;
	    text-align: left;
	    font-family: 'Roboto','sans-serif';
	    font-size: 15px;
	    padding-left: 10px;
	    width: 300px;
      }
      #floating-panel2 {
        position: absolute;
	    top: 8%;
	    left: 32%;
	    z-index: 1;
	    background-color: #fff;
	    padding: 5px;
	    border: 1px solid #999;
	    text-align: left;
	    font-family: 'Roboto','sans-serif';
	    font-size: 15px;
	    padding-left: 10px;
	    width: 300px;
      }
    </style>
  </head>
<body>
  <input id="pac-input" class="controls" type="text" placeholder="目前位址或請輸入預出發的位址" value="">
  <input id="pac-output" class="controls" type="text" placeholder="請輸入終點的位址" value="">
  <input id="pac-button" class="controls" type="button" value="送出">
  <div id="floating-panel">
  	起始建議站點:
  </div>
  <div id="floating-panel2">
  	終點建議站點:
  </div>
  <div id="map">
  </div>
  <script>
  	  var map;
  	  var directionsDisplay;
      var directionsService;
  	  
  	  AutocompleteDirectionsHandler.prototype.setupPlaceChangedListener = function(autocomplete, mode) {
        var me = this;
        autocomplete.bindTo('bounds', this.map);
        autocomplete.addListener('place_changed', function() {
          var place = autocomplete.getPlace();
          if (!place.place_id) {
            window.alert("請選擇下方清單位址!");
            return;
          }
        });

      };
  	    	  
  	  function AutocompleteDirectionsHandler(map) {
        this.map = map;
        
        var originInput = document.getElementById('pac-input');
        var destinationInput = document.getElementById('pac-output');
        
        var originAutocomplete = new google.maps.places.Autocomplete(
            originInput, {placeIdOnly: true});
        var destinationAutocomplete = new google.maps.places.Autocomplete(
            destinationInput, {placeIdOnly: true});

      }
  	  
	  function CenterControl(controlDiv, map) {
	
	      // Set CSS for the control border.
	      var controlUI = document.createElement('div');
	      controlUI.style.backgroundColor = '#fff';
	      controlUI.style.border = '2px solid #fff';
	      controlUI.style.borderRadius = '3px';
	      controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
	      controlUI.style.cursor = 'pointer';
	      controlUI.style.marginBottom = '22px';
	      //controlUI.style.textAlign = 'center';
	      controlUI.title = 'Click to recenter the map';
	      controlDiv.appendChild(controlUI);
	
	      // Set CSS for the control interior.
	      var controlText = document.createElement('div');
	      controlText.style.color = 'rgb(25,25,25)';
	      controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
	      controlText.style.fontSize = '16px';
	      controlText.style.lineHeight = '38px';
	      controlText.style.paddingLeft = '5px';
	      controlText.style.paddingRight = '5px';
	      controlText.innerHTML = 'Center Map';
	      controlUI.appendChild(controlText);
	
	      // Setup the click event listeners: simply set the map to Chicago.
	      controlUI.addEventListener('click', function() {
	        map.setCenter({lat: 24.7994476, lng: 120.9790206});
	      });	
	  }
	  
	  function initMap() {
		
		directionsDisplay = new google.maps.DirectionsRenderer;
	    directionsService = new google.maps.DirectionsService;
		  
		map = new google.maps.Map(document.getElementById('map'), {
		    center: {lat: 24.7994476, lng: 120.9790206},
		    zoom: 16
	    });
		
		directionsDisplay.setMap(map); 
		
		var input = document.getElementById('pac-input');
        var inputsearchBox = new google.maps.places.SearchBox(input);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
        
        var output = document.getElementById('pac-output');
        var outputsearchBox = new google.maps.places.SearchBox(output);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(output);
		 
	    var centerControlDiv = document.getElementById('pac-button');
        var centerControl = new CenterControl(centerControlDiv);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(centerControlDiv);
        
        map.addListener('bounds_changed', function() {
        	inputsearchBox.setBounds(map.getBounds());
        	outputsearchBox.setBounds(map.getBounds());
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
	    
	    new AutocompleteDirectionsHandler(map);
	  }
	
	  function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	    infoWindow.setPosition(pos);
	    infoWindow.setContent(browserHasGeolocation ?
	                          'Error: The Geolocation service failed.' :
	                          'Error: Your browser doesn\'t support geolocation.');
	  }
	  
		  
	  $( "#pac-button" ).click(function() {
		  var input = document.getElementById('pac-input').value;
	      var output = document.getElementById('pac-output').value;

	      var geocoderinput = new google.maps.Geocoder();
	      var geocoderoutput = new google.maps.Geocoder();
	      
	      var inputlat = 0;
	      var inputlng = 0;		      
	      var outputlat = 0;
	      var outputlng = 0;
	    	       
	      if(input == ""){
	    	  //自動帶入現在位址經緯度
	    	  if (navigator.geolocation) {
	      		navigator.geolocation.getCurrentPosition(function(position) {
	      			
	      			inputlat = 24.7994476;
	      			inputlng = 120.9790206;
	      			input = "新竹市立體育館";
	      			
	      			geocoderoutput.geocode({
				        'address': output
				    }, function (results, status) {
				    	if (status == google.maps.GeocoderStatus.OK) {
				    		outputlat = results[0].geometry.location.lat();
				    		outputlng = results[0].geometry.location.lng();
				  	      
				  	        if(inputlat != 0 && inputlng != 0 && outputlat != 0 && outputlng != 0){
				  	    	  $.ajax({
				  	            	type: "POST",
				  	            	url: "function/direction.jsp", 
				  	            	data: {             	
				  	            		inputlat:  inputlat,
				  	            		inputlng: inputlng,
				  	            		outputlat:  outputlat,
				  	            		outputlng: outputlng
				  	             	},
				  	            	success: function(response){     
				             		  var obj = JSON.parse(response);
				             		  
				             		  /* var inputstop = [];
				             		  var outputstop = [];
				             		  
				             		 var waypts = [];
				                     var checkboxArray = document.getElementById('waypoints');
				                     for (var i = 0; i < checkboxArray.length; i++) {
				                       if (checkboxArray.options[i].selected) {
				                         waypts.push({
				                           location: checkboxArray[i].value,
				                           stopover: true
				                         });
				                       }
				                     }
				             		  
				             		  for(var i=0; i<obj.length; i++){
				             			 for(var j=0; j<obj[i].length; j++){
				             				 if(i == 0){
				             					inputstop.push([obj[i][j].lat,obj[i][j].lng]);
				             				 }else if(i == 1){
				             					outputstop.push([obj[i][j].lat,obj[i][j].lng]);
				             				 }
				             			 }
				             		  } */
				  		    		  
				  		    		  var selectedMode = "WALKING";
				  		    		  
				  				      	directionsService.route({
				  				          origin: {lat: inputlat, lng: inputlng},  // Haight.
				  				          destination: {lat: outputlat,lng: outputlng},  // Ocean Beach.
				  				          waypoints: [{location: new google.maps.LatLng(obj[0][0].lat,obj[0][0].lng), stopover: true},{location: new google.maps.LatLng(obj[1][0].lat,obj[1][0].lng), stopover: true}],
				  				          // Note that Javascript allows us to access the constant
				  				          // using square brackets and a string value as its
				  				          // "property."
				  				          travelMode: google.maps.TravelMode[selectedMode]
				  				        }, function(response, status) {
				  				          if (status == google.maps.DirectionsStatus.OK) {
				  				            directionsDisplay.setDirections(response);
				  				          	var route = response.routes[0];
				  			            	// For each route, display summary information.						  			            	
				  			            	var routedisatnce = [];
				  			            	for (var i = 0; i < route.legs.length; i++) {
				  			              		routedisatnce.push(route.legs[i].distance.value);
				  			            	}
				  			            	
				  			            	$("#floating-panel").html("起始建議站點: " + obj[0][0].station);
				  			            	$("#floating-panel2").html("終點建議站點: " + obj[1][0].station);
				  			            	
				  			            	$.ajax({
							  	            	type: "POST",
							  	            	url: "function/hotsearch.jsp", 
							  	            	data: {             	
							  	            		inputlat:  inputlat,
							  	            		inputlng: inputlng,
							  	            		input: input,
							  	            		distance1: routedisatnce[0],
							  	            		inputplat: obj[0][0].lat,
							  	            		inputplng: obj[0][0].lng,
							  	            		inputp: obj[0][0].station,
							  	            		distance2: routedisatnce[1],									  	            		
							  	            		outputplat: obj[1][0].lat,
							  	            		outputplng: obj[1][0].lng,
							  	            		outputp: obj[1][0].station,
							  	            		distance3: routedisatnce[2],
							  	            		outputlat:  outputlat,
							  	            		outputlng: outputlng,
							  	            		output: output,									  	            		
							  	             	},
							  	            	success: function(response){
							  	            		//成功
							  	                },
							  	                error: function(xhr, ajaxOptions, thrownError)
							  	                { 
							  	                  alert(xhr.status); 
							  	                  alert(thrownError.Error); 
							  	                }		                
							  	            });
				  			            	
				  			              } else {
				  				            window.alert('Directions request failed due to ' + status);
				  				          }
				  				        });  
				  	                },
				  	                error: function(xhr, ajaxOptions, thrownError)
				  	                { 
				  	                  alert(xhr.status); 
				  	                  alert(thrownError.Error); 
				  	                }		                
				  	          });				  	    	  			  	    	  
				  	      }
				    	}else{
				    		alert("您輸入的終點位址無法轉為經緯度，請確認輸入的位址是否有誤!");
				    		document.getElementById("pac-output").focus();
				    		return;
				    	}			    
				    });
	      			
	      		}, function() {
	                handleNoGeolocation(browserSupportFlag);
	            });
	    	  }
	      }else{	      
		      if(output == ""){
		    	  alert("您沒輸入終點位址!");
		    	  document.getElementById("pac-output").focus();
		    	  return;
		      }else{
		    	  //轉換位址為經緯度
		    	  geocoderinput.geocode({
				        'address': input
				  }, function (results, status) {
				    	if (status == google.maps.GeocoderStatus.OK) {
				    		inputlat = results[0].geometry.location.lat();
				    		inputlng = results[0].geometry.location.lng();
				    		
				    		geocoderoutput.geocode({
						        'address': output
						    }, function (results, status) {
						    	if (status == google.maps.GeocoderStatus.OK) {
						    		outputlat = results[0].geometry.location.lat();
						    		outputlng = results[0].geometry.location.lng();
						  	      
						  	        if(inputlat != 0 && inputlng != 0 && outputlat != 0 && outputlng != 0){
						  	    	  $.ajax({
						  	            	type: "POST",
						  	            	url: "function/direction.jsp", 
						  	            	data: {             	
						  	            		inputlat:  inputlat,
						  	            		inputlng: inputlng,
						  	            		outputlat:  outputlat,
						  	            		outputlng: outputlng
						  	             	},
						  	            	success: function(response){     
						             		  var obj = JSON.parse(response);
						             		  
						             		  /* var inputstop = [];
						             		  var outputstop = [];
						             		  
						             		 var waypts = [];
						                     var checkboxArray = document.getElementById('waypoints');
						                     for (var i = 0; i < checkboxArray.length; i++) {
						                       if (checkboxArray.options[i].selected) {
						                         waypts.push({
						                           location: checkboxArray[i].value,
						                           stopover: true
						                         });
						                       }
						                     }
						             		  
						             		  for(var i=0; i<obj.length; i++){
						             			 for(var j=0; j<obj[i].length; j++){
						             				 if(i == 0){
						             					inputstop.push([obj[i][j].lat,obj[i][j].lng]);
						             				 }else if(i == 1){
						             					outputstop.push([obj[i][j].lat,obj[i][j].lng]);
						             				 }
						             			 }
						             		  } */
						  		    		  
						  		    		  var selectedMode = "WALKING";
						  		    		  
						  				      	directionsService.route({
						  				          origin: {lat: inputlat, lng: inputlng},  // Haight.
						  				          destination: {lat: outputlat,lng: outputlng},  // Ocean Beach.
						  				          waypoints: [{location: new google.maps.LatLng(obj[0][0].lat,obj[0][0].lng), stopover: true},{location: new google.maps.LatLng(obj[1][0].lat,obj[1][0].lng), stopover: true}],
						  				          // Note that Javascript allows us to access the constant
						  				          // using square brackets and a string value as its
						  				          // "property."
						  				          travelMode: google.maps.TravelMode[selectedMode]
						  				        }, function(response, status) {
						  				          if (status == google.maps.DirectionsStatus.OK) {
						  				            directionsDisplay.setDirections(response);
						  				          	var route = response.routes[0];
						  			            	// For each route, display summary information.						  			            	
						  			            	var routedisatnce = [];
						  			            	for (var i = 0; i < route.legs.length; i++) {
						  			              		routedisatnce.push(route.legs[i].distance.value);
						  			            	}
						  			            	
						  			            	$("#floating-panel").html("起始建議站點: " + obj[0][0].station);
						  			            	$("#floating-panel2").html("終點建議站點: " + obj[1][0].station);
						  			            	
						  			            	$.ajax({
									  	            	type: "POST",
									  	            	url: "function/hotsearch.jsp", 
									  	            	data: {             	
									  	            		inputlat:  inputlat,
									  	            		inputlng: inputlng,
									  	            		input: input,
									  	            		distance1: routedisatnce[0],
									  	            		inputplat: obj[0][0].lat,
									  	            		inputplng: obj[0][0].lng,
									  	            		inputp: obj[0][0].station,
									  	            		distance2: routedisatnce[1],									  	            		
									  	            		outputplat: obj[1][0].lat,
									  	            		outputplng: obj[1][0].lng,
									  	            		outputp: obj[1][0].station,
									  	            		distance3: routedisatnce[2],
									  	            		outputlat:  outputlat,
									  	            		outputlng: outputlng,
									  	            		output: output,									  	            		
									  	             	},
									  	            	success: function(response){
									  	            		//成功
									  	                },
									  	                error: function(xhr, ajaxOptions, thrownError)
									  	                { 
									  	                  alert(xhr.status); 
									  	                  alert(thrownError.Error); 
									  	                }		                
									  	            });
						  			            	
						  			              } else {
						  				            window.alert('Directions request failed due to ' + status);
						  				          }
						  				        });  
						  	                },
						  	                error: function(xhr, ajaxOptions, thrownError)
						  	                { 
						  	                  alert(xhr.status); 
						  	                  alert(thrownError.Error); 
						  	                }		                
						  	          });				  	    	  			  	    	  
						  	      }
						    	}else{
						    		alert("您輸入的終點位址無法轉為經緯度，請確認輸入的位址是否有誤!");
						    		document.getElementById("pac-output").focus();
						    		return;
						    	}			    
						    });	
				    		
				    	}else{
				    		alert("您輸入的出發位址無法轉為經緯度，請確認輸入的位址是否有誤!");
				    		document.getElementById("pac-input").focus();
				    		return;
				    	}			    
				  });	    	  		    	  
		      }
	  	  }      
	  });
		  
  </script>
</body>
</html>