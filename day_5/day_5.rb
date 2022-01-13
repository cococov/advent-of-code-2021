input = File.open('input', 'r').read.split(/\n/)
vectors = input.map { |line| line.split(/\s->\s/).map { |cord| cord.split(/,/).map(&:to_i) } }

def build_board vectors
  max = vectors.flatten.max
  Array.new(max + 1) { Array.new(max + 1) { 0 } }
end

def result_1 vectors
  board = build_board vectors

  points = vectors.map do |vector|
    x1, y1 = vector[0][0], vector[0][1]
    x2, y2 = vector[1][0], vector[1][1]

    sub_points = Array.new((x2 - x1).abs + 1).map.with_index { |point, index| [x2 - x1 >= 0 ? x1 + index : x1 - index, y1] } if y1 == y2
    sub_points ||= Array.new((y2 - y1).abs + 1).map.with_index { |point, index| [x1, y2 - y1 >= 0 ? y1 + index : y1 - index] } if x1 == x2

    sub_points
  end.flatten(1).reject(&:nil?)

  board_filled = points.reduce(board) do |board, point|
    board[point[0]][point[1]] += 1
    board
  end

  board_filled.flatten.select { |point| point > 1 }.count
end

def result_2 vectors
  board = build_board vectors

  points = vectors.map do |vector|
    x1, y1 = vector[0][0], vector[0][1]
    x2, y2 = vector[1][0], vector[1][1]

    sub_points = Array.new((x2 - x1).abs + 1).map.with_index { |point, index| [x2 - x1 >= 0 ? x1 + index : x1 - index, y1] } if y1 == y2
    sub_points ||= Array.new((y2 - y1).abs + 1).map.with_index { |point, index| [x1, y2 - y1 >= 0 ? y1 + index : y1 - index] } if x1 == x2
    sub_points ||= Array.new((x2 - x1).abs + 1).map.with_index { |point, index| [x2 - x1 >= 0 ? x1 + index : x1 - index, y2 - y1 >= 0 ? y1 + index : y1 - index] }

    sub_points
  end.flatten(1)

  board_filled = points.reduce(board) do |board, point|
    board[point[0]][point[1]] += 1
    board
  end

  board_filled.flatten.select { |point| point > 1 }.count
end

puts "Answer 1: #{result_1(vectors)}"
puts "Answer 2: #{result_2(vectors)}"
