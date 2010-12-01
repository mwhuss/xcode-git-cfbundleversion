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

PRODUCT_PLIST = File.join(ENV['BUILT_PRODUCTS_DIR'], ENV['INFOPLIST_PATH'])
REVISION = `git log --pretty=format:'' | wc -l`.scan(/\d/).to_s
BUNDLE_VERSION = "CFBundleVersion"

if File.file?(PRODUCT_PLIST) and REVISION
  
  # update product plist
  `plutil -convert xml1 #{PRODUCT_PLIST}`
  info = Plist::parse_xml(PRODUCT_PLIST)
  if info
    info[BUNDLE_VERSION] = REVISION
    info.save_plist(PRODUCT_PLIST)
  end
  `plutil -convert binary1 #{PRODUCT_PLIST}`
  
  # log
  puts "updated #{BUNDLE_VERSION} to #{REVISION}"
  
end
