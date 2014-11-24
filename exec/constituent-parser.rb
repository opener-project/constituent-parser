#!/usr/bin/env ruby

require 'opener/daemons'

require_relative '../lib/opener/constituent_parser'

daemon = Opener::Daemons::Daemon.new(Opener::ConstituentParser)

daemon.start
