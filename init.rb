APP_ROOT = File.dirname(__FILE__)

$:.unshift( File.join(APP_ROOT, 'lib') )
require 'lootbag'

lootbag = Lootbag.new('lootbags.txt')
# lootbag = Lootbag.new("new_yaml.yaml")
lootbag.launch!