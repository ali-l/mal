def pr_str(ast)
  if ast.is_a? Symbol
    ast.to_s
  elsif ast.is_a? Integer
    ast.to_s
  elsif ast.is_a? Array
    '(' + ast.map { |it| pr_str(it) }.join(' ') + ')'
  end
end