defmodule Fale.ParseTest.Macros do
    defmacro parse_test(source, expected_ast) do
        quote do
            test unquote(source) do
                {:ok, tokens, _} = :fale_lex.string(unquote(source))
                {:ok, ast} = :fale_parse.parse(tokens)
                assert(ast == unquote(expected_ast))
            end
        end
    end
end

defmodule Fale.ParseTest do
    use ExUnit.Case
    import Fale.ParseTest.Macros

    parse_test('', [])

    parse_test('module a { }', [{:module_def, "a", []}])

    parse_test(
        '''
        module a { }
        module b { }
        ''',
        [{:module_def, "a", []}, {:module_def, "b", []}]
    )

    parse_test(
        'module a { fun f() { } }',
        [{:module_def, "a", [{:fun_def, "f", [], [], []}]}]
    )

    parse_test(
        'module a { fun f() { :a; } }',
        [{:module_def, "a", [{:fun_def, "f", [], [], [{:atom_expr, "a"}]}]}]
    )

    parse_test(
        '''
        module a {
            fun f()
            require :a;
            ensure :b;
            { }
        }
        ''',
        [
            {:module_def, "a", [
                {:fun_def, "f", [], [
                    {:precondition, {:atom_expr, "a"}},
                    {:postcondition, {:atom_expr, "b"}},
                ], []},
            ]},
        ]
    )

    parse_test(
        'module a { fun f() { do { :a; :b; }; (:c); } }',
        [
            {:module_def, "a", [
                {:fun_def, "f", [], [], [
                    {:do_expr, [{:atom_expr, "a"}, {:atom_expr, "b"}]},
                    {:atom_expr, "c"},
                ]},
            ]},
        ]
    )
end
