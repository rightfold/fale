Terminals
    class
    do
    ensure
    fun
    module
    require

    identifier

    atom

    '{'
    '}'
    '('
    ')'
    ';'
.

Nonterminals
    fun_defs
    module_defs

    fun_def
    module_def

    exprs

    expr

    conditions
    parameters

    precondition
    postcondition
.

Rootsymbol module_defs.

fun_defs -> '$empty' : [].
fun_defs -> fun_def fun_defs : ['$1' | '$2'].

module_defs -> '$empty' : [].
module_defs -> module_def module_defs : ['$1' | '$2'].

fun_def -> fun identifier parameters conditions '{' exprs '}'
    : {fun_def, v('$2'), '$3', '$4', '$6'}.

module_def -> class identifier parameters '{' fun_defs '}'
    : {class_def, v('$2'), '$3', '$5'}.
module_def -> module identifier '{' fun_defs '}'
    : {module_def, v('$2'), '$4'}.

exprs -> '$empty' : [].
exprs -> expr ';' exprs : ['$1' | '$3'].

expr -> '(' expr ')' : '$2'.
expr -> do '{' exprs '}' : {do_expr, '$3'}.
expr -> atom : {atom_expr, v('$1')}.

conditions -> '$empty' : [].
conditions -> precondition conditions : ['$1' | '$2'].
conditions -> postcondition conditions : ['$1' | '$2'].

precondition -> require expr ';' : {precondition, '$2'}.
postcondition -> ensure expr ';' : {postcondition, '$2'}.

parameters -> '(' ')' : [].

Erlang code.

v({_, _, V}) -> V.
