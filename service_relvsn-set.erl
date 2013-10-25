#!/usr/bin/env escript

%% changes release version in rel/reltool.conf

main([Vsn]) ->
   {ok, Fields} = file:consult("rel/reltool.config.in"),
   NewFields = subst(Fields,Vsn),
   write_back(NewFields);

main(_) -> io:format("Must be specified exactly one argument -- new VSN for release~n").

write_back(Flds) ->
   {ok,F} = file:open("rel/reltool.config",[write]),
   lists:foreach(fun(Fld) -> io:fwrite(F,"~p.~n",[Fld]) end,Flds),
   ok = file:close(F).


subst(Flds,Vsn) ->[ subst_ll(Fld,Vsn) || Fld <- Flds ].

subst_ll( {sys, Specs}, Vsn) ->  {sys, [ subst_vsn(S,Vsn) || S <- Specs ]};
subst_ll(A,_)                -> A.

subst_vsn({rel,"{{name}}", _ , Libs},Vsn) -> {rel,"{{name}}",Vsn,Libs};
subst_vsn(A,_)                             -> A.
