---
---

$ ->
  $('.youtube').each ->
    width = 336
    height = 256
    $(@).append "<iframe width=\"#{width}\" height=\"#{height}\" src=\"http://www.youtube.com/embed/#{@id}\" frameborder=\"0\" allowfullscreen></iframe>"
