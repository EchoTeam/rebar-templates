#!/usr/bin/env escript

%% returns (output to console) current release vsn from reltool.config

main(_) ->
    Dir = filename:dirname(filename:absname(?FILE)),
    RootDir = filename:dirname(Dir),
    Rel = case file:consult(RootDir ++ "/rel/reltool.config") of
        {ok, Reltool} ->
            Sys  = proplists:get_value(sys,Reltool),
            lists:foldl(fun(X,Acc)->
                case X of
                    {rel, "as_parser", Vers,_} -> Vers;
                    _ -> Acc
                end
            end, undefined, Sys);
        {error, _} -> erlang:error("Error parsing reltool.config")
    end,
    io:format("~s", [Rel]).
