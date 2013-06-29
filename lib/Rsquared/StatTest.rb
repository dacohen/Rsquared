module Rsquared
       class StatTest
       	     attr_accessor :pvalue
       	     def significant?(alpha=0.05)
	     	 if @pvalue < alpha then
		    return true
		 else
		    return false
		 end
	     end
	     
	     def inspect
	     	 @pvalue
	     end
       end

       class AssumptionError < StandardError
       end
end