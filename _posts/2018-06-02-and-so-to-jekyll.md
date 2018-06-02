---
layout: default
title: And so to Jekyll
---
:fire:

I think it’s time to write again.

Not for any other reason than to learn from writing. And there is still so much I want to learn.

Of course, the speed of technology is moving infinitely faster than my capacity to learn.

But there’s nothing wrong with trying.

And so the first little piece of tech I’m getting to grips with is Jekyll.

It’s a nice and simple static site generator that takes your musings in markdown and converts them to HTML.

The magic bit is that when you host your site using Github pages, as I do, this happens on deployment. (And deployment sounds fancy in this context, as we’re just pushing to a Github hosted branch.)

**Getting Started with Jekyll**

Jekyll is a Ruby gem, so as long as you’re dev environment is geared up for Ruby, preparing to work with Jekyll is a simple as `bundle install jekyll`.

Alternatively, you can ensure Bundler is installed (`gem install bundler`) and then
run `bundle init` to create a `Gemfile` in your site's root directory. You can then add `gem 'jekyll'` to this and run `bundle install`. And whilst this seems like the
long and painful way of doing it, it then becomes much faster to extend your Jekyll
functionality with [Jemoji](https://github.com/jekyll/jemoji) :tada:.

Okay, with Jekyll installed, you can manually create just three files to convert a primitive static site to Jekyll:

```ruby
_layouts/default.html
index.md
config.yml
```

With that done, run `jekyll serve` in your terminal to start a development server
at `http://localhost:4000/` which will listen for changes. (Although remember to restart this server if you change `config.yml`.)

{% raw %}
All that’s required in your default.html file (other than the usual HTML) to "Jekyllify" your site is the `{{ content }}` declaration.
{% endraw %}

**Markup file metadata with Front Matter**

Markup files in Jekyll get super-cool super-quickly when you use Front Matter — a blob of YAML at the beginning of your markdown, wrapped in three dashes.

The simplest thing to do to get things working is to specify the layout you want to use for your markdown file.

```markdown
---
layout: default
---

# My Markdown Content
```

{% raw %}
And now as you change your `index.md` file, the Jekyll server will take its contents and inject them into the default template wherever you placed ``{{ content }}``.
{% endraw %}

Jekyll is pretty neat and relatively simple (if you've already got a Ruby environment set up, you've dabbled with Git and Github Pages, and you can get to grips with Markdown &mdash; so perhaps not simple in the grand scheme of things).

This post just covers the start of it. The real benefit of this separation of content (markdown) and code (HTML markup) is when you use Jekyll as a blogging platform &mdash; as I intend to do.

Well, hopefully.

:ocean:
