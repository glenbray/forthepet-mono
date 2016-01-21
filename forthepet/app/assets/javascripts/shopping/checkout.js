$(document).ready(function(){

  var billing_form = {
    first_name: $('#billing_first_name'),
    last_name: $('#billing_last_name'),
    company: $('#billing_company'),
    address1: $('#billing_address1'),
    address2: $('#billing_address2'),
    address2: $('#billing_address2'),
    suburb: $('#billing_suburb'),
    state: $('#billing_state'),
    postcode: $('#billing_postcode'),
    mobile: $('#billing_mobile'),
    phone: $('#billing_phone'),
  }

  var shipping_form = {
    first_name: $('#shipping_first_name'),
    last_name: $('#shipping_last_name'),
    company: $('#shipping_company'),
    address1: $('#shipping_address1'),
    address2: $('#shipping_address2'),
    address2: $('#shipping_address2'),
    suburb: $('#shipping_suburb'),
    state: $('#shipping_state'),
    postcode: $('#shipping_postcode'),
    mobile: $('#shipping_mobile'),
    phone: $('#shipping_phone'),

    clear: function() {
      this.first_name.val('');
      this.last_name.val('');
      this.company.val('');
      this.address1.val('');
      this.address2.val('');
      this.address2.val('');
      this.suburb.val('');
      $("#shipping_state option[value='']").attr('selected', true);
      this.postcode.val('');
      this.mobile.val('');
      this.phone.val('');
    }
  }

  billing_is_shipping = $('#billing_is_shipping');

  if(billing_is_shipping.attr('checked') ? true : false) {
    $('.shipping').hide();
  }

  billing_is_shipping.click(function(){
    checked = this.checked;
    if(checked){
      $('.shipping').hide();
      shipping_form.clear();

      shipping_form.first_name.val(billing_form.first_name.val());
      shipping_form.last_name.val(billing_form.last_name.val());
      shipping_form.company.val(billing_form.company.val());
      shipping_form.address1.val(billing_form.address1.val());
      shipping_form.address2.val(billing_form.address2.val());
      shipping_form.address2.val(billing_form.address2.val());
      shipping_form.suburb.val(billing_form.suburb.val());
      shipping_form.state.val(billing_form.state.val());
      shipping_form.postcode.val(billing_form.postcode.val());
      shipping_form.mobile.val(billing_form.mobile.val());
      shipping_form.phone.val(billing_form.phone.val());
    }
    else{
      $('.shipping').show();
      shipping_form.clear();
    }
  });

});
