module TestData
  MAX_NUMBER = 1_000_000

  def random_data_set(size)
    array = size.times.map { |i| rand(MAX_NUMBER) }
    (array.size / 10).times { fold_array!(array) }
    array
  end

  private

  def fold_array!(array)
    (array.size / 10).times do
      start = rand(array.size)
      size = rand(array.size - start) + 1
      array[start, size] = [array[start, size]]
    end
  end
end
