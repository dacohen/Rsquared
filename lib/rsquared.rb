require "Rsquared/version"
require "rubygems"
require "distribution"
require "constants"
require "complex"
require "enumerableext.rb"	      

require 'Rsquared/StatTest'
require 'Rsquared/KSTest'
require 'Rsquared/GrubbsTest'
require 'Rsquared/TTest'
require 'Rsquared/PropTest'

module Rsquared

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
 

	##
	# Modifies p-value to account for tails and/or two-sided tests
	#
	
	def adjustForSided(pvalue, sided)
	    if sided == Upper.tail then
	       return 1.0-pvalue
	    elsif sided == Two.sided then
	       return [(1.0-pvalue)*2.0, pvalue*2.0].min
	    end
        end

	 module_function :kscv, :grubbscv
  end
end
