input = File.open('input', 'r').read.split(/,/)

class Fish
  attr_reader :timer, :first_timer, :gave_birth

  def initialize timer
    @timer = timer
    @first_timer = true
    @gave_birth = false
  end

  def new_day
    @gave_birth = false
    @timer = @timer - 1
    if @timer == -1
      @timer = 6
      @gave_birth = true
    end
  end

  def gave_birth?
    @gave_birth
  end
end

# nice but inefficient solution
def fishes_after_n_days initial_state, days
  fishes = initial_state.map { |timer| Fish.new(timer.to_i) }
  days.times do
    fishes.each(&:new_day)
    new_fishes = fishes.select { |fish| fish.gave_birth? }.count
    new_fishes.times { fishes << Fish.new(8) }
  end
  fishes.count
end

# ugly but efficient solution
def fishes_after_n_days_with_good_performance initial_state, days
  fishes = initial_state.map(&:to_i)
  totals = fishes.reduce(Array.new(9) { 0 }) { |totals, timer| totals[timer] += 1; totals }
  days.times do
    zero = totals.shift
    totals.push zero
    totals[6] += zero
  end
  totals.sum
end

def result_1 initial_state
  fishes_after_n_days_with_good_performance(initial_state, 80)
end

def result_2 initial_state
  fishes_after_n_days_with_good_performance(initial_state, 256)
end

puts "Answer 1: #{result_1(input)}"
puts "Answer 2: #{result_2(input)}"
