---
layout: page
title: "Projects"
description: ""
---
{% include JB/setup %}

<ul>
  {% for post in site.categories.projects %}
    <li>
      {% assign foundImage = 0 %}
      {% assign images = post.content | split:"<img " %}
      {% for image in images %}
        {% if image contains 'src' %}
                {% assign html = image | split:"/>" | first %}
		<a href="{{ post.url }}">
                <img {{ html }} width="150" height="150" style="float: left"/>
		</a>
                {% assign foundImage = 1 %}
		{% break %}
        {% endif %}
      {% endfor %}
 <b><font size="4"><a href="{{ post.url }}">{{ post.title }}</a></font></b><br>
        {{ post.content | strip_html | truncatewords:40}}<br>
            <a href="{{ post.url }}">Read more...</a><br><br><br><br>
    </li>
  {% endfor %}
</ul>
