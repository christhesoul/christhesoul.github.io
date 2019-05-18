---
title: Writing about Programming.
headline: Writing about Programming.
---

<ul class="list pl0">
  {%- for post in site.posts %}
    <li class="mb2"><h3><a href="{{ post.url }}" class="link navy bg-animate hover-bg-light-yellow">{{ post.title }}</a></h3></li>
  {%- endfor %}
</ul>
