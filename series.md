---
layout: page
title: Series
---

<div id="archives">
{% for category in site.categories %}
  {% capture category_name %}{{ category | first }}{% endcapture %}
  {% unless category_name contains "series" %}{% continue %}{% endunless %}
  <div class="archive-group">
    <div id="#{{ category_name | slugize }}"></div>
    <p></p>

    <h3 class="category-head">{{ category_name }}</h3>
    <a name="{{ category_name | slugize }}"></a>
    {% for post in site.categories[category_name] %}
    <article class="archive-item">
      <h4><a href="{{ site.baseurl }}{{ post.url }}">{{post.title}}</a></h4>
    </article>
    {% endfor %}
  </div>
{% endfor %}
</div>
