#!/usr/bin/env ruby

require 'tilt'
require 'slim'
require 'redcarpet'

INDEX_TUFTE_MD = 'content/index.tufte.md'
TEMPLATE_SLIM = 'content/template.slim'
SIDENOTE_SLIM = 'content/sidenote.slim'

SIDENOTE_DST_RE = -> (key) { /{#{key}}/ }
SIDENOTE_SRC_RE = /^{([A-z0-9]+)}: (.+)/

def file_at(path)
  File.join File.dirname(__FILE__), path
end

def read_file_at(path)
  File.open(file_at(path), 'r') { |f| f.read }
end

def template_from(path)
  Tilt.new file_at path
end

def split_sidenotes(txt)
  body = []
  sidenotes = {}
  txt.split(/\n/).each do |line|
    match = SIDENOTE_SRC_RE.match line
    body << line and next unless match
    sidenotes[match[1]] = match[2]
  end
  [body.join("\n"), sidenotes]
end

def inject_sidenotes(body, sidenotes)
  template = template_from SIDENOTE_SLIM
  sidenotes.each do |key, content|
    body.gsub!(SIDENOTE_DST_RE.call(key), template.render(nil, key: key, content: content))
  end
  body
end

def add_sidenotes(raw)
  inject_sidenotes(*split_sidenotes(raw))
end

def add_newthoughts(raw)
  processed = raw.split(/\n/).map do |line|
    match = /^(.+)✂(.+)/.match line
    if match
      "<span class=\"newthought\">#{match[1].rstrip}</span>#{match[2]}"
    else
      line
    end
  end
  processed.join "\n"
end

def process_tufte(raw)
  with_sidenotes = add_sidenotes raw
  add_newthoughts with_sidenotes
end

def render_md(source)
  Tilt::RedcarpetTemplate.new { source }.render
end

def tufte_md_to_html
  raw = read_file_at INDEX_TUFTE_MD
  processed = process_tufte raw
  render_md processed
end

def render(html_body)
  template_from(TEMPLATE_SLIM).render { html_body }
end

puts render(tufte_md_to_html)
