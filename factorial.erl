-module(factorial).
-export([calculate/1]).

calculate(N) when N >= 0 ->
    Pid = self(),
    NbCores = erlang:system_info(schedulers_online),
    ChunkSize =
        N div NbCores +
            if
                N rem NbCores > 0 -> 1;
                true -> 0
            end,
    Ranges = [{(I - 1) * ChunkSize + 1, min(I * ChunkSize, N)} || I <- lists:seq(1, NbCores)],
    [spawn(fun() -> Pid ! calculate_range(Start, End) end) || {Start, End} <- Ranges],
    receive_results(NbCores, 1).

calculate_range(Start, End) when Start > End ->
    1;
calculate_range(Start, End) ->
    lists:foldl(fun(X, Acc) -> X * Acc end, 1, lists:seq(Start, End)).

receive_results(0, Acc) ->
    Acc;
receive_results(N, Acc) ->
    receive
        ChunkAcc ->
            receive_results(N - 1, Acc * ChunkAcc)
    after 5000 ->
        exit(timeout)
    end.
