-module($app_config).

-behaviour(gen_server).

%% API
-export([
         start_link/0,
         web_port/0
        ]).

%% gen_server callbacks
-export([
         init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3
        ]).

-define(SERVER, ?MODULE).

-record($app_config_state, {
         }).

%%------------------------------------------------------------------------------
%% API
%%------------------------------------------------------------------------------
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

web_port() ->
  get_value(web_port).

%%------------------------------------------------------------------------------
%% gen_server callbacks
%%------------------------------------------------------------------------------
init([]) ->
    rewrite_config(),

    {ok, #$app_config_state{}}.


handle_call(_, _From, State) ->
    {ok, State}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(_, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%------------------------------------------------------------------------------
%% Internals
%%------------------------------------------------------------------------------
rewrite_config() ->
  case application:get_env($app, mode) of
    undefined -> ok;
    {ok, Mode} ->
      {ok, Modes} = application:get_env($app, modes),
      case lists:keyfind(Mode, 1, Modes) of
        { Mode, Config } ->
                          lists:foreach(fun({Par, Val}) -> application:set_env($app, Par, Val) end, Config),
                          application:set_env($app, modes, undefined);
        false -> io:format(user, "Mode ~p not found ~n", [Mode])
      end
  end.

get_value(Name) ->
  gproc:get_env(l, $app, Name, [os_env, app_env, error]).

get_value(Name, Default) ->
  gproc:get_env(l, $app, Name, [os_env, app_env, {default, Default}]).
