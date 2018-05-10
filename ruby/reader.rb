TOKEN_PATTERN = Regexp.new(/[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"|;.*|[^\s\[\]{}('"`,;)]*)/)

class Reader
  def initialize(tokens)
    @tokens = tokens
    @position = 0
  end

  def next
    @position += 1
    @tokens[@position - 1]
  end

  def peek
    @tokens[@position]
  end
end

def tokenize(string)
  string.scan(TOKEN_PATTERN).flatten
end

def read_str(string)
  read_form(Reader.new(tokenize(string)))
end

def read_form(reader)
  return if reader.peek.empty?
  reader.peek == '(' ? read_list(reader)  : read_atom(reader)
end

def read_list(reader)
  tokens = []

  reader.next

  loop do
    token = read_form(reader)
    break if token == :')'
    tokens << token
  end

  tokens
end

def read_atom(reader)
  token = reader.next

  int = Integer(token) rescue nil

  int || token.to_sym
end