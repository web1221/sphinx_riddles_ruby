require('rspec')
require('riddle')
describe('#RiddleTest') do

  before(:each) do
    @tester = RiddleTest.new()
  end

  it('will return a 2d array of three riddles with their answers') do
    expect(@tester.riddles.length).to(eq(3))
    expect(@tester.riddles[0].length).to(eq(2))
  end
end
