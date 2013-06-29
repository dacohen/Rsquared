module Rsquared

       class PropTest < StatTest
       	     def initialize(data, p0, sided)
	     	 @data = data
		 @p0 = p0
		 @sided = sided

		 if (@data.length*@p0 < 10.0) or (@data.length*(1.0-@p0) < 10.0) then
		    raise AssumptionError, "The number of successes or failures prediced by the proportion is too small"
		 end
		 
		 @stderr = Math.sqrt((@p0*(1.0-@p0))/@data.length)
		 @pstat = ((@data.sum.to_f/@data.length.to_f) - @p0)/@stderr
		 @pvalue = Distribution::Normal::cdf(@pstat)
		 self.setSidedness!(@sided)
	    end


	    ##
	    # Returns the z-statistic
	    
	    def statistic
	    	@pstat
            end

	    ## significant?, inspect implemented by inhertance
	end
end
