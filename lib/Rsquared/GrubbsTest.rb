module Rsquared
##
  # Tests for outliers on either side of the data
  # grubbs = Rsquared::GrubbsTest.new(data)
  # grubbs.significant? => Boolean
  #

  class GrubbsTest
	  ##
	  # Initializes the Test object with an array of numerical data
	  #

	  def initialize(data)
	     @data = data.sort
   	     @gstat = [((@data.mean - @data.min)/@data.stddev).abs, ((@data.mean - @data.max)/@data.stddev).abs].max
	  end
	  
	  ##
	  # Returns a boolean indicating the significance of the test at the 5% level
	  #	  

	  def significant?(alpha=0.05)
	     if @gstat > Helper::grubbscv(@data.length, alpha) then
	     	return true
	     else
		return false
	     end
	  end

	  def inspect
	      significant?
	  end

	  ##
	  # Returns the test statistic as a float
	  #

	  def statistic
	      @gstat
	  end

	  alias_method :outlier?, :significant?	      
  end
end