Search = {}

Search.init = function(){
  this.initHandler()
}

Search.initHandler = function(){
  $('#search_rooms').on('click', function(){
    Search.getHotels()
  })
}


Search.getHotels = function(){
  $('#results_body').empty()
  start_date = $('#start_date').val()
  end_date = $('#end_date').val()
  room_type = $('#room_type').val()
  if(start_date == '' || end_date == '')
  {
    alert('dates are required')
    return
  } 
  $.ajax({
      async: false,
      url: '/search/check_avaiblity',
      data: {'start_date': start_date, 'end_date': end_date, 'room_type': room_type },
      method: "get",
      success: function (data) {
        if (data.length > 0){
          Search.appendData(data)
        }
        else{
          $('.results').addClass('d-none')
          $('.no-results').removeClass('d-none')
        }
      }
  })
}

Search.appendData = function(data){
  $.each( data, function( key, value ) {
    var room_number = '<td>' + value['name']+ '</td>'

    var cost = '<td>' + value['cost']+ '</td>'

    var type = '<td>' + value['type']+ '</td>'

    var amenities = ''
    $.each( value['amenites'], function( id, amenity ) {
      amenities = amenities + amenity['name'] + '<br>'
    })
    amenities = '<td>' + amenities + '<td>'
    book_button = '<td><button data-id='+value['id'] +'>Book</button></td>'
    $('#results_body').append('<tr>' + room_number + cost + type + amenities + book_button+ '</tr>')
  });
  Search.registerBook()
}

Search.registerBook = function(){
  $('[data-id]').unbind('click')
  $('[data-id]').on('click', function(){
    id = $(this).attr('data-id')
    Search.createBooking(id)
  })
}
Search.createBooking = function(id){
  start_date = $('#start_date').val()
  end_date = $('#end_date').val()
  $.ajax({
      async: false,
      url: '/bookings',
      data: {'start_date': start_date, 'end_date': end_date, 'room_number': id },
      method: "post",
      success: function (data) {
        // console.log(data['message']['id'])
        alert('booked Room successfully , Room: ' +  data['message']['room'])
      }
  })
}

