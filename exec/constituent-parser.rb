#!/usr/bin/env ruby

require 'opener/daemons'
require_relative '../lib/opener/constituent_parser'

options = Opener::Daemons::OptParser.parse!(ARGV)
daemon  = Opener::Daemons::Daemon.new(Opener::ConstituentParser, options)

daemon.start