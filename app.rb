require('sinatra')
require('sinatra/reloader')
require('./lib/riddle')
require('pry')
also_reload('lib/**/*.rb')

riddle = RiddleTest.new()

get('/') do
  @riddle = riddle
  erb(:sphinx)
end

post('/reset') do
  riddle = RiddleTest.new()
  @riddle = riddle
  erb(:sphinx)
end

get('/add_riddle') do
  erb(:add_riddle)
end

post('/add_riddle') do
  values = *params.values
  new_riddle = values.shift
  new_answer = values.select { |v| v != ''}
  riddle.new_riddle(new_riddle, new_answer)
  erb(:win)
end

post('/') do
  @riddle = riddle
  @guess = params[:answer]
  correct = riddle.correct_guess?(@guess)
  if correct || riddle.guesses == false
    riddle.guesses = true
    riddle.next_riddle
    if riddle.current_riddle == riddle.riddles.length
      if riddle.wrong.length > 0
        @wrong = riddle.wrong
        riddle = RiddleTest.new()
        return erb(:fail)
      else
        riddle = RiddleTest.new()
        return erb(:win)
      end
    end
    return erb(:sphinx)
  else
    riddle.guesses = false
    return erb(:retry)
  end

end
