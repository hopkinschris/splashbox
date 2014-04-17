$(document).ready ->

  photo_el = document.querySelector('.photo-count')
  user_el = document.querySelector('.user-count')

  setTimeout ->
    photo_el.innerHTML = 327237
    user_el.innerHTML = 1124
  , 1000
