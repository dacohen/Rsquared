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

	     ##
	     # Modifies p-value to account for tails and/or two-sided tests
	     #
	
	     def setSidedness!(sided)
	     	 if sided == Upper.tail then
	       	    @pvalue = 1.0-@pvalue
	   	 elsif sided == Two.sided then
	       	    @pvalue = [(1.0-@pvalue)*2.0, @pvalue*2.0].min
	    	end
             end
       end

       class AssumptionError < StandardError
       end
end