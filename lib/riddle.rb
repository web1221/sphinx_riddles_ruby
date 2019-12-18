class RiddleTest

  attr_reader(:riddles, :current_riddle, :wrong)

  def initialize()
    @riddles = make_riddles()
    @current_riddle = 0
    @wrong = []
  end

  def make_riddles
    questions = File.open('./q.txt').read.strip.split("\n")
    answers = File.open('./a.txt').read.strip.split("\n").map do |a|
      a.downcase.split('&')
    end
    q_and_a = questions.zip(answers)
    number_arr = Array(1..questions.length).shuffle[0,3]
    riddles = []
    number_arr.each { |n| riddles.push(q_and_a[n]) }
    riddles
  end

  def next_riddle
    @current_riddle += 1
  end

  def get_riddle
    @riddles[@current_riddle][0]
  end

  def make_guess(guess)
    if !@riddles[@current_riddle][1].include?(guess.downcase.chomp)
      @wrong.push(@riddles[@current_riddle])
    end
    next_riddle
  end

  def new_riddle(riddle, answers)
    @riddles.push([riddle, answers])
    answer_string = answers.join('&')
    File.open('./q.txt') do |file| file.write(riddle) end
    File.open('./a.txt') do |file| file.write(answer_string) end
  end

end
