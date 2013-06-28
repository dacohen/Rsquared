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

	 def significant?
	     if @ksstat > Helper::kscv(@data.length) then
	     	return true
	     else
		return false
	     end
	 end

	 def normal?
	     !self.significant?
	 end

	 def inspect
	     significant?
	 end

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
	  def initialize(data)
	     @data = data.sort
   	     @gstat = [((@data.mean - @data.min)/@data.stddev).abs, ((@data.mean - @data.max)/@data.stddev).abs].max
	  end

	  def significant?
	     if @gstat > Helper::grubbscv(@data.length) then
	     	return true
	     else
		return false
	     end
	  end

	  def inspect
	      significant?
	  end

	  def statistic
	      @gstat
	  end

	  alias_method :outlier?, :significant?	      
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
	# grubbscv(n) => Float
	# Calculates the Grubbs critical value
	
	def grubbscv(n)
	    tcv = Distribution::T::p_value(0.05/(2*n), n-2)
	    return ((n-1)/Math.sqrt(n))*Math.sqrt(tcv**2/((n-2)+tcv**2))
	end
 
	 module_function :kscv, :grubbscv
  end
end
