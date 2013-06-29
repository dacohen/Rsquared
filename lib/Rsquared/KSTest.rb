module Rsquared
##
  # KSTest implements the Kolomogorov-Smirnov test for normality
  # kstest = Rsquared::KSTest.new(data)
  # kstest.normal? => Boolean, indicates normality of data at 5% confidence
  # 

  class KSTest
  	##
	# Intitializes the test object with an array of numerical data
	#

  	def initialize(data)
	    @data = data.std.sort!
	    fn = 0
	    d = []
	    range = @data.max - @data.min
	    @data.each_with_index do |x, i|
	    	# Calculate Fn
		fn = i + 1
		d[i] = fn/@data.length.to_f - Distribution::Normal::cdf(x)
		fn = 0.0
	    end
	    @ksstat = d.max
	    return @ksstat
	 end
	 
	 ##
	 # Returns a boolean indiciating the significance of the test a the 5% level
	 #

	 def significant?
	     if @ksstat > Helper::kscv(@data.length) then
	     	return true
	     else
		return false
	     end
	 end

	 ##
	 # Returns logical opposite of significance
	 #

	 def normal?
	     !self.significant?
	 end

	 def inspect
	     significant?
	 end
	 
	 ##
	 # Returns the test statistic
	 #

	 def statistic
	     @ksstat
	 end
  end
end