#!/usr/bin/env ruby

require 'tilt'
require 'slim'
require 'redcarpet'

INDEX_PATH = 'content/index.tufte.md'
TEMPLATE_PATH = 'content/template.slim'

def file_at(path)
  File.join File.dirname(__FILE__), path
end

def read_file_at(path)
  File.open(file_at(path), 'r') { |f| f.read }
end

def template_from(path)
  Tilt.new file_at path
end

def split_footnotes(txt)
  re = /^\[(\d+)\]: (.+)/
  body = []
  footnotes = {}
  txt.split(/\n/).each do |line|
    match = re.match line
    body << line and next unless match
    footnotes[match[1]] = match[2]
  end
  [body.join("\n"), footnotes]
end

def inject_footnotes(body, footnotes)
  footnotes.each do |key, content|
    body.gsub!(/\[#{key}\]/, "<span class=\"sidenote\">#{content}</span>")
  end
  body
end

def add_footnotes(raw)
  inject_footnotes(*split_footnotes(raw))
end

def process_tufte(raw)
  add_footnotes raw
end

def render_md(source)
  Tilt::RedcarpetTemplate.new { source }.render
end

def tufte_md_to_html
  raw = read_file_at INDEX_PATH
  processed = process_tufte raw
  render_md processed
end

def render(html_body)
  template_from(TEMPLATE_PATH).render { html_body }
end

puts render(tufte_md_to_html)
