---
layout: page
title: "Tips"
description: ""
---
{% include JB/setup %}

<ul>
  {% for post in site.categories.tips %}
    <li>
      {% if post.outside_link %}
        {%assign URL = post.outside_link %}
      {% else %}
        {%assign URL = post.url %}
      {% endif %}

      {% assign foundImage = 0 %}
      {% assign images = post.content | split:"<img " %}
      {% for image in images %}
        {% if image contains 'src' %}
                {% assign html = image | split:"/>" | first %}
		<a href="{{ URL }}">
                <img {{ html }} width="150" height="150" style="float: left"/>
		</a>
                {% assign foundImage = 1 %}
		{% break %}
        {% endif %}
      {% endfor %}
 <b><font size="4"><a href="{{ URL }}">{{ post.title }}</a></font></b><br>
        {{ post.content | strip_html | truncatewords:40}}<br>
            <a href="{{ URL }}">Read more...</a><br><br><br><br>
    </li>
  {% endfor %}
</ul>