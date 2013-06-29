module Rsquared
##
  # Tests for deviation of sample mean from expected mean
  # ttest = Rsquared::TTest.new(data, mu0, sided)
  # mu0 is the expected value of the sample mean
  # Supply Rsquared::Upper.tail, Rsquared::Lower.tail or Rsquared::Two.sided
  # Use Upper.tail when you suspect that the sample mean will be greater than the expected mean
  # Use Lower.tail when you suspect that the sample mean will be smaller than the expected mean
  # Use Two.sided when you suspect neither

  class TTest
  	##
	# Initializes the TTest object with the supplied arguments
	#

  	def initialize(data, mu0, sided)
	    @data = data
  	    @mu0 = mu0
	    @sided = sided
	    
	    if KSTest.new(@data).significant? and @data.length < 40 then
	       raise AssumptionException, "The data is not close enough to a normal distribution for such a small sample size"
	    end
	    if GrubbsTest.new(@data).outlier? then
	       raise AssumptionException, "Your data has one or more outliers, which the T-Distribution cannot handle"
	    end

	    @tstat = (@data.mean - @mu0)/(data.stddev/Math.sqrt(@data.length))
	    @pvalue = Distribution::T::cdf(@tstat, @data.length-1)
	    if @sided == Upper.tail then
	       @pvalue = 1.0-@pvalue
	    elsif @sided == Two.sided then
	       @pvalue = [(1.0-@pvalue)*2.0, @pvalue*2.0].min
	    end
	 end

	 def inspect
	     @pvalue
	 end

	 ##
	 # Returns the t-statistic
	 #

	 def statistic
	     @tstat
	 end

	 ##
	 # Checks for significance at the supplied alpha level
	 #

	 def significant?(alpha=0.05)
	     if @pvalue < alpha then
	     	return true
	     else
		return false
	     end
	 end
   end
end