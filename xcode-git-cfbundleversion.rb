#!/usr/bin/ruby
# xcode-git-cfbundleversion.rb
# Update CFBundleVersion in Info.plist file with short Git revision string
# http://github.com/guicocoa/xcode-git-cfbundleversion/
#
# This is based on
# http://github.com/digdog/xcode-git-cfbundleversion/
# http://github.com/jsallis/xcode-git-versioner
# http://github.com/juretta/iphone-project-tools/tree/v1.0.3

require 'rubygems'
begin
  require 'Plist'
rescue LoadError => e
  puts "You need to install the 'Plist' gem: [sudo] gem install plist"
  exit 1
end

raise "Must be run from Xcode" unless ENV['XCODE_VERSION_ACTUAL']

PLIST_FILE = File.join(ENV['BUILT_PRODUCTS_DIR'], ENV['INFOPLIST_PATH'])
REVISION = `git log --pretty=format:'' | wc -l`.scan(/\d/).to_s

if File.file?(PLIST_FILE) and REVISION
  `plutil -convert xml1 #{PLIST_FILE}`
  
  pl = Plist::parse_xml(PLIST_FILE)
  if pl
    pl["CFBundleVersion"] = REVISION
    pl.save_plist(PLIST_FILE)
  end
  
  `plutil -convert binary1 #{PLIST_FILE}`
  
  puts "updated CFBundleVersion to #{REVISION}"
end
