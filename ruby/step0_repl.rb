def _read
  gets.chomp
end

def _eval(string)
  string
end

def _print(string)
  puts string
end

def rep
  _print _eval _read
end

loop do
  print 'user> '
  rep
end