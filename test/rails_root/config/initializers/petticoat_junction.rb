# This simulates loading the gem without relying on vendor/gems

gem_path = File.join(File.dirname(__FILE__), *%w(.. .. .. ..))
gem_lib_path = File.join(gem_path, "lib")

$LOAD_PATH.unshift(gem_lib_path)
load File.join(gem_path, 'rails', 'init.rb')
