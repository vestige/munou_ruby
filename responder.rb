class Responder
  def initialize(name, dict)
    @name = name
    @dict = dict
  end

  def response(input)
    return ''
  end

  def select_random(ary)
    return ary.sample
  end
 
  attr_reader :name
end

class WhatResponder < Responder
  def response(input)
    return "#{input}ってなに？"
  end
end

class RandomResponder < Responder
  def response(input)
    return select_random(@dict.random)
  end
end

class PatternResponder < Responder
  def response(input)
    @dict.pattern.each do |ptn|
      if m = input.match(ptn['pattern'])
        resp = select_random(ptn['phrases'].split('|'))
        return resp.gsub(/%match%/, m.to_s)
      end
    end
    return select_random(@dict.random)
  end
end
