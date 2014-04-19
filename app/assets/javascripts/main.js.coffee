$(document).ready ->

  photo_el = document.querySelector('.photo-count')
  user_el = document.querySelector('.user-count')
  waitlist_el = document.querySelector('.waitlist-count')

  setTimeout ->
    photo_el?.innerHTML = $('.photo-count').data('count')
    user_el?.innerHTML = $('.user-count').data('count')
    waitlist_el?.innerHTML = $('.waitlist-count').data('count')
  , 1000
