module Rsquared
##
  # Tests for deviation of sample mean from expected mean
  # ttest = Rsquared::TTest.new(data, mu0, sided)
  # mu0 is the expected value of the sample mean
  # Supply Rsquared::Upper.tail, Rsquared::Lower.tail or Rsquared::Two.sided
  # Use Upper.tail when you suspect that the sample mean will be greater than the expected mean
  # Use Lower.tail when you suspect that the sample mean will be smaller than the expected mean
  # Use Two.sided when you suspect neither

  class TTest < StatTest
  	##
	# Initializes the TTest object with the supplied arguments
	#

  	def initialize(data, mu0, sided)
	    @data = data
  	    @mu0 = mu0
	    @sided = sided
	    
	    if KSTest.new(@data).significant? and @data.length < 40 then
	       raise AssumptionError, "The data is not close enough to a normal distribution for such a small sample size"
	    end
	    if GrubbsTest.new(@data).outlier? then
	       raise AssumptionError, "Your data has one or more outliers, which the T-Distribution cannot handle"
	    end

	    @tstat = (@data.mean - @mu0)/(data.stddev/Math.sqrt(@data.length))
	    @pvalue = Helper::adjustForSided(Distribution::T::cdf(@tstat, @data.length-1), @sided)
	 end

	 ##
	 # Returns the t-statistic
	 #

	 def statistic
	     @tstat
	 end

	 ## significant?, inspect implemented by inheritance

   end
end