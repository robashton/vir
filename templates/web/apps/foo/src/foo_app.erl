-module($app_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).


%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
  rewrite_config(),

  Endpoints =
  [
   {"/[...]", cowboy_static, {priv_dir, $app, <<"www">>}}
  ],

  Dispatch = cowboy_router:compile([
                                    {'_', lists:flatten(Endpoints)}
                                   ]),

  {ok, _} = cowboy:start_http(cowboy_http_listener, 5,
                              [{port, $app_config:web_port()}],
                              [{env, [{dispatch, Dispatch}]}
                              ])
  %% Start supervisors here
  %%
  .


stop(_State) ->
  ok.

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


