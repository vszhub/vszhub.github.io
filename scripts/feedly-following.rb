#!/usr/bin/ruby

require 'json'

list = JSON.parse(ARGV[0])
list.sort! { |a,b| b['subscribers'] <=> a['subscribers'] }
list = list.select { |elem| elem['title'] != 'VSZHub' }

data = "---\nlayout: page\ntitle: Following\npermalink: /following/\n---\n"
data += "| Blogs | Feedly Subscribers |\n|:--- |:--- |\n"
list.each { |elem| data += "| [#{elem['title']}](#{elem['website']}) | #{elem['subscribers']} |\n"}

data += "\n#{Time.now}\n"

File.write("_pages/following.md", data)
