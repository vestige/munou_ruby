require 'responder'
require 'dictionary'

class Unmo
  def initialize(name)
    @name = name
    @dict = Dictionary.new

    @resp_what = WhatResponder.new('Wht', @dict)
    @resp_random = RandomResponder.new('Rnd', @dict)
    @resp_pattern = PatternResponder.new('Ptn', @dict)

    @responder = @resp_pattern
  end

  def dialogue(input)
    case rand(100)
    when 0..59
      @responder = @resp_pattern
    when 60..89
      @responder = @resp_random
    else
      @responder = @resp_what
    end
    return @responder.response(input)
  end

  def responder_name
    return @responder.name
  end

  attr_reader :name
end