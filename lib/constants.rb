KSCV = [0.975, 0.842, 0.708, 0.624, 0.565, 0.521, 0.486, 0.457, 0.432, 0.410, 0.391, 0.375, 0.361, 0.349, 0.338, 0.328, 0.318, 0.309, 0.301, 0.294]

module Rsquared
       class Upper
       	     def self.tail
	     	 return 1
     	     end
       end

       class Lower
       	     def self.tail
	     	 return -1
	     end
       end
    
       class Two
       	     def self.sided
	     	 return true
	     end
       end

       class AssumptionError < StandardError
       end
end