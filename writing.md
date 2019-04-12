---
title: Writing about Programming.
layout: default
---

<ul class="list pl0">
  {%- for post in site.posts %}
    <li class="mb2"><a href="{{ post.url }}" class="link navy bg-animate hover-bg-light-yellow">{{ post.title }}</a></li>
  {%- endfor %}
</ul>
