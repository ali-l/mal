require_relative './reader'
require_relative './printer'

def _read
  read_str(gets.chomp)
end

def _eval(ast)
  ast
end

def _print(ast)
  puts pr_str(ast)
end

def rep
  _print _eval _read
end

loop do
  print 'user> '
  rep
end