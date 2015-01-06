-module($app_config).

-export([
         web_port/0
        ]).

web_port() ->
  get_value(web_port).

get_value(Name) ->
  gproc:get_env(l, $app, Name, [os_env, app_env, error]).

get_value(Name, Default) ->
  gproc:get_env(l, $app, Name, [os_env, app_env, {default, Default}]).



