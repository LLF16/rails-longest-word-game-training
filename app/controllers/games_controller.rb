require 'json'
require'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new
    @alphabet = ('a'..'z').to_a
    @alphabet.each {|letter| p letter.upcase!}
    10.times do
      @letters << @alphabet.sample(1)
      @letters.flatten!
    end
  end

  def score
    # raise
    # binding.pry

    guess_array = params[:word].upcase.split("")
    letters_array = params[:letters].split

    if (guess_array - letters_array).empty?

      api_url = 'https://wagon-dictionary.herokuapp.com/'
      guess = params[:word]
      api_call_url = api_url + guess

      answer_serialize = open(api_call_url).read
      @answer = JSON.parse(answer_serialize)
      raise

      if @answer["found"]
        @result =  "Good job!"
      else
        @result = "Not a proper English word, try again"
      end

    else
      @result = "Sorry but #{params[:word]} can't be built out of #{letters_array}"
    end

  end

  # private

  # def word_params
  #   params.require(:game).permit(:word)
  # end
end
