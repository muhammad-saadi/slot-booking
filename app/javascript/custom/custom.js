$(document).on('ready turbolinks:load', () => {
  $('.check-slot').on('click', function(event) {
    event.preventDefault();
    var date = this.parentElement.children.date.value;
    var duration = this.parentElement.children.duration.value;
    $.ajax({
      url: '/slots',
      type: 'GET',
      data: {
        date: date,
        duration: duration
      }
    });
  });

  $('.flash').delay(2000).fadeOut(800);
})
