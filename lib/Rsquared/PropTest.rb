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
		 @pstat = ((@data.sum/@data.length) - @p0)/@stderr
		 @pvalue = Helper::adjustForSided(Distribution::Normal::cdf(@pstat), @sided)
	    end


	    ##
	    # Returns the z-statistic
	    
	    def statistic
	    	@pstat
            end

	    ## significant?, inspect implemented by inhertance
	end
end