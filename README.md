# mplewis.com

This is the source code for [mplewis.com](http://mplewis.com).

# Why?

I am a big fan of [Edward Tufte's books](https://smile.amazon.com/The-Visual-Display-Quantitative-Information/dp/0961392142) and [Tufte CSS](https://edwardtufte.github.io/tufte-css/), a stylesheet that emulates them. I wanted to make my simple single-page site look like that.

Tufte CSS is sort of a pain to write by hand. Every sidenote needs a `<label>`, `<input>`, and `<span>` tag. In the past, I created them with [JavaScript](https://github.com/edwardtufte/tufte-css/issues/66). This time, I spent some time creating a simple build system to convert a Markdown-ish file (`index.tufte.md`) into Tufte CSS-compatible HTML.

# Why a custom build system?

mplewis.com is a single-page site. All the Ruby code, including a Rakefile, makes up about 120 total lines of code. I don't need anything else.

# Tufte-MD format

Tufte-MD is not a standard. It's just what I use to generate this site. It's like Markdown with a couple of extra rules:

* `✂` indicates the part of a paragraph that should be designated as a `newthought` – small caps emphasis at the beginning of a paragraph.
* `{some-tag}` defines or references a sidenote.

Here's some sample code in Tufte-MD:

```markdown
# I'm Matt Lewis.

I grew up ✂ in Wausau, Wisconsin. After high school, I attended the University of Minnesota{umn} and graduated in Computer Engineering in December 2014.

{umn}: Go Gophers!
```

And here's what it compiles down to:

```html
<h1>I&#39;m Matt Lewis.</h1>
<p>
  <span class="newthought">
    I grew up
  </span>
  in Wausau, Wisconsin. After high school, I attended the University of Minnesota
  <label class="margin-toggle sidenote-number" for="sidenote-umn"></label>
  <input class="margin-toggle" id="sidenote-umn" type="checkbox" />
  <span class="sidenote">
    Go Gophers!
  </span>
  and graduated in Computer Engineering in December 2014.
</p>
```

# License

MIT
