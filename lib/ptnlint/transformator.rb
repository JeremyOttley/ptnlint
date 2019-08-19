require 'parslet'

module PGNLint
  class Transform < Parslet::Transform
    rule(:tag_name => simple(:t), :tag_value => simple(:n)) {{t.to_s => n.to_s} }

    #rule(:move_number => simple(:x)) { }

  end
end
