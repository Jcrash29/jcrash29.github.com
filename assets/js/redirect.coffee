---
---

$ ->
  $('.redirect').each ->
    var num = Math.floor(Math.random() * 999),
        img = $(this);
    
    img.attr('href', 'https://polldaddy.com/vote.php?va=20&pt=0&r=2&p=9898848&a=45346723%2C&o=&t=51&token=2a66ad1755b2e036d04264c027a27125&pz=' + num);
	