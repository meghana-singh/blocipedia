class Amount 
    #attr_accessor :def_amount
    
    def initialize (def_amount)
      @@def_amount = def_amount
    end
    
    def self.default_amount 
       @@def_amount
    end
end