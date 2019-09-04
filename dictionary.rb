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
        @pattern.push({'pattern' => pattern, 'phrases' => phrases})
      end
    end
  end

  attr_reader :random, :pattern
end
