---
layout: page
title: Weekly Agendas & Announcements
nav_exclude: false
nav_order: 2
description: A feed containing all of the class announcements.
---

# Weekly Agendas & Announcements

{% assign announcements = site.announcements | reverse %}
{% for announcement in announcements %}
{{ announcement }}
{% endfor %}
