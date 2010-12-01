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

GIT="/opt/local/bin/git"
PLUTIL = "/usr/bin/plutil"
PLIST_FILE = File.join(ENV['BUILT_PRODUCTS_DIR'], ENV['INFOPLIST_PATH'])
REVISION = `#{GIT} log --pretty=format:'' | wc -l`.scan(/\d/)

puts "#{REVISION}"

if File.file?(PLIST_FILE) and REVISION
  `#{PLUTIL} -convert xml1 #{PLIST_FILE}`
  
  pl = Plist::parse_xml(PLIST_FILE)
  if pl
    pl["CFBundleVersion"] = REVISION.to_s
    pl.save_plist(PLIST_FILE)
  end
  
  `#{PLUTIL} -convert binary1 #{PLIST_FILE}`
end