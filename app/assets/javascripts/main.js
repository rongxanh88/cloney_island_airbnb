$(document).ready(function() {

  $('.dropbtn').click(function() {
    event.preventDefault();
  });

  $('.host-dropdown').hover(
    function() {
      $('.host-dropdown-content').addClass('show');
    }, function() {
      $('.host-dropdown-content').removeClass('show');
    }
  );

  $('.signin-dropdown').hover(
    function() {
      $('.signin-dropdown-content').addClass('show');
    }, function() {
      $('.signin-dropdown-content').removeClass('show');
    }
  );

  $('.slider').slick({});

  $('.slick-next').removeClass('slick-arrow').addClass('fa fa-chevron-right')
  $('.slick-prev').removeClass('slick-arrow').addClass('fa fa-chevron-left')

  $('button:contains("Next")').each(function(){
    $(this).html($(this).html().split("Next").join(""));
  });

  $('button:contains("Previous")').each(function(){
    $(this).html($(this).html().split("Previous").join(""));
  });

  $('ul.slider button').css('display', 'none')

  $('ul.slider').hover(
    function() {
      $('ul.slider button').css('display', 'block');
    }, function() {
      $('ul.slider button').css('display', 'none');
    }
  );
    // Datepicker for Search Bar
    var nowTemp = new Date();
    var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

    var checkin = $('#dpd1').datepicker({
        onRender: function(date) {
            return date.valueOf() < now.valueOf() ? 'disabled' : '';
        }
    }).on('changeDate', function(ev) {
        if (ev.date.valueOf() > checkout.date.valueOf()) {
            var newDate = new Date(ev.date)
            newDate.setDate(newDate.getDate() + 1);
            checkout.setValue(newDate);
        }
        checkin.hide();
        $('#dpd2')[0].focus();
    }).data('datepicker');
    var checkout = $('#dpd2').datepicker({
        onRender: function(date) {
            return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
        }
    }).on('changeDate', function(ev) {
        checkout.hide();
    }).data('datepicker');

    // Datepicker for Booking Form
    $('.datepicker').datepicker({
        format: 'yyyy/mm/dd'
    });
});
