input = File.open('input', 'r').read.split(/\n\n/)
numbers = input.shift.split(/,/).map(&:to_i)
boards = input.map { |board| board.split(/\n/).map { |row| row.strip.split(/\s+/).map(&:to_i) } }

def set_mark state, number
  state.map do |board|
    board.map do |row|
      row.map { |cell| cell == number ? 'X' : cell }
    end
  end
end

def someone_win? state
  state.each do |board|
    board.each do |row|
      return board if row.uniq === ['X']
    end
    board.transpose.each do |row|
      return board if row.uniq === ['X']
    end
  end
  false
end

def get_board_score board, winner_number
  board.flatten.map { |i| i == 'X' ? 0 : i }.sum * winner_number
end

def bingo_subsystem numbers, boards
  mut_state = boards.dup

  numbers.each do |number|
    mut_state = set_mark(mut_state, number)
    winner_board = someone_win?(mut_state)
    return { winner_board: winner_board, winner_number: number } if winner_board
  end
end

def bingo_subsystem_for_loose numbers, boards
  mut_state = boards.dup

  numbers.each_with_index do |number, index|
    mut_state = set_mark(mut_state, number)
    winner_board = someone_win?(mut_state)
    while winner_board
      return { winner_board: winner_board, winner_number: number } if mut_state.size == 1
      mut_state.delete(winner_board) if winner_board
      winner_board = someone_win?(mut_state)
    end
  end
end

def result_1 numbers, boards
  result = bingo_subsystem(numbers, boards)
  get_board_score(result[:winner_board], result[:winner_number])
end

def result_2 numbers, boards
  result = bingo_subsystem_for_loose(numbers, boards)
  get_board_score(result[:winner_board], result[:winner_number])
end

puts "Answer 2: #{result_1(numbers, boards)}"
puts "Answer 2: #{result_2(numbers, boards)}"
