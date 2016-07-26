require 'sass/plugin/rack'
require_relative 'app'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run PastaBin
