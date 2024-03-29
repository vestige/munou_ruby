class Dictionary
  def initialize
    @random = []
    open('dic/rand.txt') do |f|
      f.each do |line|
        line.chomp!
        next if line.empty?
        @random.push(line)
      end
    end

    @pattern = []
    open('dic/pattern.txt') do |f|
      f.each do |line|
        pattern, phrases = line.chomp.split("¥t")
        next if pattern.nil? or phrases.nil?
        @pattern.push(PatternItem.new(pattern, phrases))
      end
    end
  end

  attr_reader :random, :pattern
end

class PatternItem
  SEPARATOR = /^((-?¥d+)##)?(.*)$/

  def initialize(pattern, phrases)
    SEPARATOR =~ pattern
    @modify, @pattern = $2.to_i, $3

    @phrases = []
    phrases.split('|').each do |it|
      SEPARATOR =~ it
      @phrases.push({'need' => $2.to_i, 'phrase' => $3})
    end
  end

  def match(str)
    return str.match(@pattern)
  end

  def choice(mood)
    choices = []
    @phrases.each do |p|
      choices.push(p['phrase']) if suitable?(p['need'], mood)
    end
    return (choices.empty?) ? nil : select_random(choices)
  end

  def suitable?(need, mood)
    return true if need == 0
    if need > 0
      return mood > need
    else
      return mood < need
    end
  end

  attr_reader :modify, :pattern, :phrases
end


