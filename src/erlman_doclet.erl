%%% @author karlll <karl@ninjacontrol.com>
%%% @doc
%%%
%%% @end

-module(erlman_doclet).
-export([run/2]).

-include_lib("edoc/include/edoc_doclet.hrl").

run(#doclet_gen{}=Command, Context) ->
    Sources = Command#doclet_gen.sources,
    Dir = Context#context.dir,
    Env = Context#context.env,
    Opts = Context#context.opts,
    process(Sources,Dir,Env,Opts);

run(#doclet_toc{}=Command, Context) ->
    io:format("Toc: Not implemented").

process(Sources,Dir,Env,Opts) ->
    process(Sources,[],Dir,Env,Opts).
				
process([{Module,Package,FileName,Path}|T],Acc,Dir,Env,Opts) ->
    File = filename:join(Path,FileName),
    case get_doc(File,Env,Opts) of
	{ok,Document} ->
	    DocName = lists:concat([filename:basename(FileName,".erl"),".xml"]),
	    write_doc(Document,Dir,DocName);
	{error,Other} ->
	    io:format("Error~n",[])
    end,
    process(T,Acc,Dir,Env,Opts);

process([],Acc,Dir,Env,Opts) ->
    ok.

get_doc(File,Env,Opts) ->
    case edoc:get_doc(File,Env,Opts) of
	{M,D} ->
	    Document = edoc:layout(D,Opts),
	    {ok,Document};
	Other ->
	    {error,Other}
    end.
    
write_doc(Data,Dir,FileName) ->
    edoc_lib:write_file(Data,Dir,FileName).
