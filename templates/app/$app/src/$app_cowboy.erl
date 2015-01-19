%%%-------------------------------------------------------------------
%%% @author id3as <>
%%% @copyright (C) 2014, id3as
%%% @doc
%%%
%%% @end
%%% Created : 24 Nov 2014 by id3as <>
%%%-------------------------------------------------------------------
-module($app_cowboy).

-behaviour(gen_server).

%% API
-export([start_link/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {}).

%%--------------------------------------------------------------------
%% API
%%--------------------------------------------------------------------
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%%--------------------------------------------------------------------
%% gen_server callbacks
%%--------------------------------------------------------------------
init([]) ->

    Dispatch = cowboy_router:compile([{'_', resources()}]),

    {ok, _} = cowboy:start_http($app_http_listener, 10,
				[{port, $app_config:web_port()}],
				[
                                 {env, [
                                        {dispatch, Dispatch}
                                       ]}
                                ]),

    {ok, #state{}}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%--------------------------------------------------------------------
%% Internal functions
%%--------------------------------------------------------------------
resources() ->
    [
     {"/[...]", cowboy_static, {priv_dir, $app, <<"www">>}}
    ].
