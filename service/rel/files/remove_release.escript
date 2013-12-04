#!/usr/bin/env escript
%%! -noshell -noinput
%% -*- mode: erlang;erlang-indent-level: 4;indent-tabs-mode: nil -*-
%% ex: ft=erlang ts=4 sw=4 et

-define(TIMEOUT, 60000).
-define(INFO(Fmt,Args), io:format(Fmt,Args)).
-define(ERR(Fmt,Args), begin io:format(Fmt,Args), halt(1) end).

main([NodeName, Cookie, RelToDel, BackRel]) ->
    TargetNode = start_distribution(NodeName, Cookie),
    case rpc:call(TargetNode, release_handler, which_releases,[], ?TIMEOUT) of
        ListReleases when is_list(ListReleases) -> %% [{Name, Vsn, Apps, Status }]
            %% check the status of  RelToDel
            case [Status || {_,R,_,Status} <- ListReleases, R == RelToDel  ] of
                [S] -> remove_rls(TargetNode,S, RelToDel, BackRel);
                []          -> ?ERR("No such release was installed ~p~n",[RelToDel]);
                Else        -> ?ERR("Cannot get status of ~p (~p)~n",[RelToDel,Else])
            end;
        Else -> ?ERR("Cannot get list of releases ~p~n",[Else])
    end;                

main(_) ->
    halt(1).

start_distribution(NodeName, Cookie) ->
    MyNode = make_script_node(NodeName),
    {ok, _Pid} = net_kernel:start([MyNode, shortnames]),
    erlang:set_cookie(node(), list_to_atom(Cookie)),
    TargetNode = make_target_node(NodeName),
    case {net_kernel:hidden_connect_node(TargetNode),
          net_adm:ping(TargetNode)} of
        {true, pong} ->
            ok;
        {_, pang} ->
            ?ERR("Node ~p not responding to pings.\n", [TargetNode])
    end,
    TargetNode.

make_target_node(Node) ->
    [_, Host] = string:tokens(atom_to_list(node()), "@"),
    list_to_atom(lists:concat([Node, "@", Host])).

make_script_node(Node) ->
    list_to_atom(lists:concat([Node, "_remover_", os:getpid()])).

remove_rls(TargetNode,old,RelToDel,_) ->
    ok = rpc:call(TargetNode,release_handler, remove_release,[RelToDel],?TIMEOUT),
    ?INFO("Release ~p is removed",[RelToDel]);

remove_rls(TargetNode,permanent,RelToDel,BackRel) ->
    {ok, _, Desc} = rpc:call(TargetNode, release_handler,check_install_release, [BackRel], ?TIMEOUT),
    {ok, _, Desc} = rpc:call(TargetNode, release_handler,install_release, [BackRel], ?TIMEOUT),
    ?INFO("Installed Release ~p~n", [BackRel]),
    ok = rpc:call(TargetNode, release_handler, make_permanent, [BackRel], ?TIMEOUT),
    ?INFO("Made Release ~p Permanent~n", [BackRel]),
    ok = rpc:call(TargetNode,release_handler, remove_release,[RelToDel],?TIMEOUT),
    ?INFO("Release ~p is removed",[RelToDel]).








