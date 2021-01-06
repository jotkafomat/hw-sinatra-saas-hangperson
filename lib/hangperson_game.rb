class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

    attr_reader :word, :guesses, :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(word)
    raise ArgumentError if word == nil
    raise ArgumentError if word.empty? || word.count("a-zA-Z") == 0
    if @word.include?(word.downcase) && !@guesses.include?(word.downcase)
      @guesses << word.downcase
    elsif !@guesses.include?(word.downcase) && !@wrong_guesses.include?(word.downcase)
      @wrong_guesses << word.downcase
    elsif word.downcase == @word
      return true
    elsif word.downcase != @word
      return false
    end
  end

  def word_with_guesses
    @word.chars.map {
      |letter| @guesses.include?(letter) ? letter : "-"
    }.join
  end

  def check_win_or_lose
    if word_with_guesses() == @word
      return :win
    elsif @wrong_guesses.length == 7
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
