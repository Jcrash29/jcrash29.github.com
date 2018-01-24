---
---

$ ->
  $('.redirect').each ->
    url = "https://polldaddy.com/vote.php?va=20&pt=0&r=2&p=9898848&a=45346723%2C&o=&t=51&token=2a66ad1755b2e036d04264c027a27125&pz="
    rand = Math.floor(Math.random() * 999).toString();
	url = url.concat rand
    setTimeout(function () {
       window.location.href = url; //will redirect to your blog page (an ex: blog.html)
    }, 2000);
