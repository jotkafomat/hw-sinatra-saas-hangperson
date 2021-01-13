class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_reader :word, :inputs

  def initialize(word)
    @word = word
    @inputs = []
  end

  def guesses
    @inputs
      .filter {
        |letter| word.include?(letter)
      }
      .join
  end

  def wrong_guesses
    @inputs
      .filter {
        |letter| !word.include?(letter)
      }
      .join
  end

  def guess(input)
    raise ArgumentError if input == nil
    letter = input.downcase
    raise ArgumentError if letter.empty? || letter.count("a-z") == 0
    return false if @inputs.include?(letter)
    @inputs.push(letter)
    return true
  end

  def word_with_guesses
    word.chars.map {
      |letter| guesses.include?(letter) ? letter : "-"
    }.join
  end

  def check_win_or_lose
    if word_with_guesses() == word
      return :win
    elsif wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
