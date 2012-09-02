%%% @author karll <karl@ninjacontrol.com>
%%% @doc
%%%
%%% @end

-module(erlman_layout).
-export([module/2,overview/2,package/2,type/1]).
-include_lib("xmerl/include/xmerl.hrl").

module(Element, Options) -> 
    xmerl:export_simple([Element], xmerl_otpsgml, []).

overview(Element, Options) -> 
    xmerl:export_simple([Element], xmerl_otpsgml, []).
package(Element, Options) ->
    xmerl:export_simple([Element], xmerl_otpsgml, []).

type(Element) -> 
    xmerl:export_simple_content([Element], xmerl_otpsgml, []).
