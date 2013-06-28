require "Rsquared/version"
require "rubygems"
require "distribution"
require "constants"
require "complex"
require "enumerableext.rb"	      

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

  ##
  # The Helper module implements uncommon statistical functions directly
  # For use by experts only
  # = Example
  #
  # Rsquared::Helper::kscv(30) => 0.190
  #
  module Helper
	##
	# kscv(n) => Float
	# Estimates the 5% critical value of the Kolomogorov-Smirnov distribution given sample size
	#
	
	def kscv(n)
	    if n < 1 then
	       return 1.0
	    elsif n < 21 then
	       return KSCV[n-1]
	    elsif n >= 20 and n < 25 then
	       return 0.270
	    elsif n >= 25 and n < 30 then
	       return 0.240
	    elsif n >= 30 and n < 35 then
	       return 0.230
	    elsif n > 35 then
	       return 1.36/Math.sqrt(n)
	    end
	end

	##
	# grubbscv(n, alpha) => Float
	# Calculates the Grubbs critical value
	#
	
	def grubbscv(n, alpha)
	    tcv = Distribution::T::p_value(alpha/(2*n), n-2)
	    return ((n-1)/Math.sqrt(n))*Math.sqrt(tcv**2/((n-2)+tcv**2))
	end
 
	 module_function :kscv, :grubbscv
  end
end
