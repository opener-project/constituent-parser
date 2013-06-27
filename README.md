# Constituent Parser

This repository contains a constituent parser component that provides a CLI
interface and a webservice for the various constituent parser kernels.

## Requirements

* Ruby 1.9.2 or newer

## Installation

Installing as a regular Gem:

    gem install opener-constituent-parser

Using Bundler:

    gem 'opener-constituent-parser',
      :git    => 'git@github.com:opener-project/constituent-parser.git',
      :branch => 'master'

Using specific install:

    gem install specific_install
    gem specific_install opener-constituent-parser \
       -l https://github.com/opener-project/constituent-parser.git

## Usage

    cat some_input_file.kaf | constituent-parser -l en
