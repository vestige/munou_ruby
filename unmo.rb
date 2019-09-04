require 'responder'
require 'dictionary'


class Emotion
  MOOD_MIN = -15
  MOOD_MAX = 15
  MOOD_RECOVERY = 0.5

  def initialize(dict)
    @dictionary = dict
    @mood = 0
  end

  def update(input)
    @dictionary.pattern.each do |ptn_item|
      if ptn_item.match(input)
        adjust_mood(ptn_item.modify)
        break
      end
    end

    if @mood < 0
      @mood += MOOD_RECOVERY
    elsif @mood > 0
      @mood -= MOOD_RECOVERY
    end
  end

  def adjust_mood(val)
    @mood += val
    if @mood > MOOD_MAX
      @mood = MOOD_MAX
    elsif @mood < MOOD_MIN
      @mood = MOOD_MIN
    end
  end

  attr_reader :mood
end

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