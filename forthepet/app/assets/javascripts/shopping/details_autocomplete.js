
function detectIE() {
    var ua = window.navigator.userAgent;

    var ieBrowser = false;

    var msie = ua.indexOf('MSIE ');
    if (msie > 0) {
        // IE 10 or older => return version number
        // return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
        ieBrowser = true;
    }

    var trident = ua.indexOf('Trident/');
    if (trident > 0) {
        // IE 11 => return version number
        var rv = ua.indexOf('rv:');
        return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
        ieBrowser = true;
    }

    var edge = ua.indexOf('Edge/');
    if (edge > 0) {
       // IE 12 => return version number
       return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
       ieBrowser = true
    }

    // other browser
    return ieBrowser;
}

if(detectIE() == false) {
  var autocomplete_options = {
    types: ['address'],
    componentRestrictions: {country: "au"}
  };

  var componentForm = {
    subpremise: 'short_name',
    street_number: 'short_name',
    route: 'long_name',
    locality: 'long_name',
    administrative_area_level_1: 'short_name',
    postal_code: 'short_name'
  };

  billing_address_input = document.getElementById('billing_address1');
  billing_suburb_input = document.getElementById('billing_suburb');
  billing_state_input = document.getElementById('billing_state');
  billing_postcode_input = document.getElementById('billing_postcode');

  shipping_address_input = document.getElementById('shipping_address1');
  shipping_suburb_input = document.getElementById('shipping_suburb');
  shipping_state_input = document.getElementById('shipping_state');
  shipping_postcode_input = document.getElementById('shipping_postcode');

  billing_autocomplete = new google.maps.places.Autocomplete(billing_address_input, autocomplete_options);
  shipping_autocomplete = new google.maps.places.Autocomplete(shipping_address_input, autocomplete_options);


  google.maps.event.addListener(billing_autocomplete, 'place_changed', function() {
    var result = billing_autocomplete.getPlace();

    if(result == undefined) {
      return;
    } else {

      unitNo = '';
      streetNo = '';
      address = '';
      suburb = '';
      state = '';
      postcode = '';

      for(var i = 0; i < result.address_components.length; i++) {
        var addressComponents = result.address_components[i];
        var addressType = addressComponents.types[0];
        value = addressComponents[componentForm[addressType]];

        switch(addressType) {
          case 'subpremise':
            unitNo = value;
            break;
          case 'street_number':
            streetNo = value
            break;
          case 'route':
            address = value
            break;
          case 'locality':
            suburb = value
            break;
          case 'administrative_area_level_1':
            state = value
            break;
          case 'postal_code':
            postcode = value
            break;
          default:
            break;
        }
      }

      billing_address_input.value = '';
      billing_suburb_input.value = '';
      billing_state_input.value = '';
      billing_postcode_input.value = '';

      billing_address1.blur();

      if(unitNo != '') {
        billing_address1.value = unitNo + ' / ' + streetNo + ' ' + address;
      }
      else {
        billing_address1.value = streetNo + ' ' + address;
      }
      billing_address2.focus();

      billing_suburb_input.value = suburb;
      billing_state_input.value = state;
      billing_postcode_input.value = postcode;
    }
  });


  google.maps.event.addListener(shipping_autocomplete, 'place_changed', function() {
    var result = shipping_autocomplete.getPlace();

    if(result == undefined) {
      return;
    } else {

      unitNo = '';
      streetNo = '';
      address = '';
      suburb = '';
      state = '';
      postcode = '';

      for(var i = 0; i < result.address_components.length; i++) {
        var addressComponents = result.address_components[i];
        var addressType = addressComponents.types[0];
        value = addressComponents[componentForm[addressType]];

        switch(addressType) {
          case 'subpremise':
            unitNo = value;
            break;
          case 'street_number':
            streetNo = value
            break;
          case 'route':
            address = value
            break;
          case 'locality':
            suburb = value
            break;
          case 'administrative_area_level_1':
            state = value
            break;
          case 'postal_code':
            postcode = value
            break;
          default:
            break;
        }
      }

      shipping_address_input.value = '';
      shipping_suburb_input.value = '';
      shipping_state_input.value = '';
      shipping_postcode_input.value = '';

      shipping_address1.blur();
      if(unitNo != '') {
        shipping_address1.value = unitNo + ' / ' + streetNo + ' ' + address;
      }
      else {
        shipping_address1.value = streetNo + ' ' + address;
      }
      shipping_address2.focus();

      shipping_suburb_input.value = suburb;
      shipping_state_input.value = state;
      shipping_postcode_input.value = postcode;
    }
  });
}