defmodule RLE do

  use Diet.Transformations

  reductions do

    { :rle, {[], result} } ->
            {:done, result |> Enum.reverse}

    { :rle, {[ {a, n}, a | tail], result }} ->
            {:rle, {[{a, n+1} | tail], result}}

    { :rle, {[ a, a | tail ], result } } ->
            {:rle, {[{a, 2} | tail], result }}

    { :rle, {[a | tail ], result } } ->
            {:rle, {tail, [a | result]  }}

    { :rle, list } ->
            {:rle, {list, []}}
  end

end

alias Diet.Stepper

runner = Stepper.new(RLE, nil)
# Diet.debug(runner)

list = "aabccccdeeffffff" |> String.codepoints

{ result, _runner } = Stepper.run(runner, { :rle, list })

IO.inspect result # => {:done, [{"a", 2}, "b", {"c", 4}, "d", {"e", 2}, {"f", 6}]}
