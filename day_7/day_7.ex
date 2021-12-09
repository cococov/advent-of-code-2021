defmodule Day7 do
  def calculate_fuel_consumption(input, callback) do
    {min, max} = Enum.min_max(input)

    min..max
    |> Enum.to_list()
    |> Enum.map(fn x -> Enum.map(input, callback.(x)) end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.min()
  end

  def result_1(input) do
    calculate_fuel_consumption(input, fn x -> &abs(x - &1) end)
  end

  def result_2(input) do
    calculate_fuel_consumption(input, fn x ->
      fn y ->
        n = abs(x - y)
        trunc(n * (n + 1) / 2)
      end
    end)
  end
end

input =
  File.read!('input')
  |> String.split(~r/,/)
  |> Enum.map(&String.to_integer/1)

IO.puts("Answer 1: #{Day7.result_1(input)}")
IO.puts("Answer 2: #{Day7.result_2(input)}")
