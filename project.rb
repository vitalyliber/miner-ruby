require 'rspec'

class Minesweeper
  attr_accessor :rows

  def initialize
    @rows = []
    8.times do
      @rows << Array.new(5) do
        {
            hide: true,
            bomb: [true, false].sample
        }
      end
    end
  end

  def board
    p @rows
  end

  def show
    @rows.each do |row|
      row.each do |el|
        if el[:hide]
          print 'x'
        else
          print el[:bomb] ? 'b' : el[:bombs]
        end
      end
      print "\n"
    end
  end

  def get_cells(row, column)
    elements = [
        [row - 1, column - 1],
        [row - 1, column],
        [row - 1, column + 1],
        [row, column + 1],
        [row + 1, column + 1],
        [row + 1, column],
        [row + 1, column - 1],
        [row, column - 1],
    ]

    elements.select do |element|
      element[0] >= 0 && element[1] >= 0
    end
  end

  def start
    show
    'Enter a row and column:'
    result = gets.chomp
    row, column = result.split(' ')

    cell = @rows[row.to_i][column.to_i]

    bombs = 0
    bombs += @rows.dig(row.to_i - 1, column.to_i, :bomb) ? 1 : 0
    bombs += @rows.dig(row.to_i - 1, column.to_i - 1, :bomb) ? 1 : 0
    bombs += @rows.dig(row.to_i - 1, column.to_i + 1, :bomb) ? 1 : 0

    bombs += @rows.dig(row.to_i + 1, column.to_i, :bomb) ? 1 : 0
    bombs += @rows.dig(row.to_i + 1, column.to_i - 1, :bomb) ? 1 : 0
    bombs += @rows.dig(row.to_i + 1, column.to_i + 1, :bomb) ? 1 : 0

    bombs += @rows.dig(row.to_i, column.to_i - 1, :bomb) ? 1 : 0
    bombs += @rows.dig(row.to_i, column.to_i + 1, :bomb) ? 1 : 0

    @rows[row.to_i][column.to_i] = { hide: false, bomb: cell[:bomb], bombs: bombs }

    if cell[:bomb]
      show
      return p('Boom!')
    end

    start
  end

end

minesweeper = Minesweeper.new
# minesweeper.board
minesweeper.start

# describe 'Minesweeper' do
#   it 'get coordinates 0, 0' do
#     minesweeper = Minesweeper.new
#     result = minesweeper.get_cells(0,0)
#     expect(result).to match_array([[0, 1], [1,0], [1,1]] )
#   end
#
#   it 'get coordinates 4, 7' do
#     minesweeper = Minesweeper.new
#     result = minesweeper.get_cells(4, 7)
#     expect(result).to match_array([[3, 6], [3, 7], [3, 8], [4, 6], [4, 8], [5, 6], [5, 7], [5, 8]])
#   end
#
#   it 'get coordinates 1, 1' do
#     minesweeper = Minesweeper.new
#     result = minesweeper.get_cells(1,1)
#     expect(result).to match_array([[0, 0], [0,1], [0,2], [1,2], [2,2], [2,1], [2,0], [1,0]] )
#   end
# end