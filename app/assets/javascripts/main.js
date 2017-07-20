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

})
