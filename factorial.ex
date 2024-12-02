defmodule Factorial do
  def calculate(0), do: 1

  def calculate(n) when n > 0 do
    nb_cores = :erlang.system_info(:schedulers_online)
    chunk_size = div(n + nb_cores - 1, nb_cores)

    1..n
    |> Enum.chunk_every(chunk_size)
    |> Enum.map(fn chunk ->
      Task.async(fn -> Enum.reduce(chunk, 1, &*/2) end)
    end)
    |> Enum.map(&Task.await/1)
    |> Enum.reduce(1, &*/2)
  end
end
