-module(factorial).
-export([calculate/1]).
-import(erlang, [spawn/3, receive/1, wait/1]).

calculate(N) when N >= 0 ->
    Pid = self(),
    NbCores = erlang:system_info(schedulers_online),
    ChunkSize = N div NbCores,
    Chunks = lists:split(ChunkSize, lists:seq(1, N)),
    Pids = [spawn(fun() -> Pid ! {self(), calculate_chunk(Chunk)} end) || Chunk <- Chunks],
    Acc = receive_results(NbCores),
    wait(Pids),
    Acc.

calculate_chunk(Chunk) ->
    lists:foldl(fun(X, Acc) -> X * Acc end, 1, Chunk).

receive_results(0) -> 1;
receive_results(N) ->
    {_, Acc} = receive({_, Acc}),
    Acc * receive_results(N-1).
