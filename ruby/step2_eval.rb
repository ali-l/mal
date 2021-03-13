require_relative './reader'
require_relative './printer'

REPL_ENV = {
  :+ => ->(a, b) { a + b },
  :- => ->(a, b) { a - b },
  :* => ->(a, b) { a * b },
  :/ => ->(a, b) { (a / b).round }
}.freeze

def _read
  read_str(gets.chomp)
end

def _eval(ast, env)
  ast

  if !ast.is_a?(Array)
    eval_ast(ast, env)
  elsif ast.empty?
    ast
  else
    evaled_ast = eval_ast(ast, env)
    evaled_ast[0].call(*evaled_ast[1..-1])
  end
end

def eval_ast(ast, env)
  return env[ast] if ast.is_a?(Symbol)

  return ast.map { |node| _eval(node, env) } if ast.is_a?(Array)

  ast
end

def _print(ast)
  puts pr_str(ast)
end

def rep
  _print(_eval(_read, REPL_ENV))
end

loop do
  print 'user> '
  rep
end
