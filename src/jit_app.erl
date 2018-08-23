-module(jit_app).
-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-export([watch/3, watch/0, traced/1, some_fun/0]).

start(_StartType, _StartArgs) ->
    jit_sup:start_link().

stop(_State) ->
    ok.


%% watch(M, F, A) when apply(erlang, is_integer, [A]) == true ->

%% http://erlang.org/pipermail/erlang-questions/2016-September/090091.html
%% > It is not possible to trace on what is called "guard bifs", i.e. functions
%%   in the erlang module that can be used in guards.

%% Tracing NIFs work though. Probably ports too then.

watch(M, F, A) ->
    recon_trace:calls({M, F, A}, 10).

some_fun() ->
    ok.

traced(M) ->
    apply(M, some_fun, []).

watch() ->
    %% watch(erlang, apply, 3).
    watch(?MODULE, traced, 1).
