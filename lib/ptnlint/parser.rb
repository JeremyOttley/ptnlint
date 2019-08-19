require 'parslet'

module PTNLint
  class Parser < Parslet::Parser

    rule(:space) { match("[[:space:]]").repeat(1) }
    rule(:space?) { space.maybe }

    rule(:string) { match('[[:print:]&&[^}]]').repeat(1) }

    rule(:tag_section) { tag_pair.repeat }
  
    rule(:tag_pair) do
      str("[") >>
      tag_name.as(:tag_name) >>
      space >> tag_value >>
      str("]") >>
      space?
    end
  
    rule(:tag_name) { match('[A-Za-z_]').repeat(1) }
  
    rule(:tag_value) do
      str('"') >>
      match('[[:print:]&&[^"]]').repeat(1).as(:tag_value) >>
      str('"')
    end

    #rule(:game_termination) { str('1-0') | str('0-1') | str('1/2-1/2') | str('*') }
  
    rule(:move_number) { match('[0-9]').repeat(1) >> str('.').repeat(1) }

    rule(:comment) { str("{") >> space? >> string.as(:comment) >> space? >> str("}") }
    # TODO multiline comments

  end
end
