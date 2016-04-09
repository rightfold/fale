Definitions.



Rules.

class           : {token, {class, TokenLine, undefined}}.
do              : {token, {do, TokenLine, undefined}}.
ensure          : {token, {ensure, TokenLine, undefined}}.
fun             : {token, {'fun', TokenLine, undefined}}.
module          : {token, {module, TokenLine, undefined}}.
require         : {token, {require, TokenLine, undefined}}.

[a-zA-Z_]+      : {token, {identifier, TokenLine, encode(TokenChars)}}.

:[a-zA-Z_]+     : {token, {atom, TokenLine, encode(tl(TokenChars))}}.

[\s\t\r\n]+     : skip_token.

{               : {token, {'{', TokenLine, undefined}}.
}               : {token, {'}', TokenLine, undefined}}.
\(              : {token, {'(', TokenLine, undefined}}.
\)              : {token, {')', TokenLine, undefined}}.
;               : {token, {';', TokenLine, undefined}}.

Erlang code.

encode(S) -> list_to_binary(S).
