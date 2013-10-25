#!/usr/bin/env escript

%% returns (output to console) current release vsn from reltool.config

main(_) ->
   Rel = case file:consult("rel/reltool.config") of
      {ok, Reltool} ->
         Sys  = proplists:get_value(sys,Reltool),
         lists:foldl(
            fun(X,Acc)-> 
                  case X of 
                      {rel,"{{name}}",Vers,_} -> Vers; 
                  _ -> Acc
               end 
         end,
         undefined,
         Sys);
      {error, _} -> "none"
   end,
   io:format("~s",[Rel]).

