#!/usr/bin/env escript

%% returns (output to console) root application name

main(_) ->
    Dir = filename:dirname(filename:absname(?FILE)),
    RootDir = filename:dirname(Dir),
    AppName = case filelib:wildcard(RootDir ++ "/src/*.app.src") of
        [File] -> filename:basename(File, ".app.src");
        [] ->
            case filelib:wildcard(RootDir ++ "/ebin/*.app") of
                [File] -> filename:basename(File, ".app");
                [] -> erlang:error("app file not found")
            end
    end,
    io:format("~s", [AppName]).
