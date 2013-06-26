require "Rsquared/version"
require "constants"
require 'complex'

module Math
       ##
       # Calculates the 2F1 Hypergeometic Function
       #
       def self.hypergeom(a, b, c, z)
	   s = []
	   cj = []
	   cj[0] = 1
	   s[0] = cj[0]
       	   (0..10000).each do |j|
	   	cj[j+1] = cj[j]*(((a+j)*(b+j))/(c+j))*(z/(j+1))
		s[j+1] = s[j] + cj[j+1]
           end
		return s.last
	end

	##
	# Calculates the lower incomplete gamma function
	#
	def self.incompleteGamma(a, x)
	    s = []
	    gam = []
	    gama = Math.gamma(a)
	    gam[0] = Math.gamma(a+1)
	    s[0] = (Math.gamma(a)/gam[0])
	    (1..100).each do |n|
	    	gam[n] = (a+n)*gam[n-1]
		term = (gama/gam[n])*(x**n)
		s[n] = s[n-1] + term
	    end
	    return s.last*Math.exp(-x)*(x**a)
         end

	 def self.invErf(x)
	     c = []
	     c[0] = 1.0
	     c[1] = 1.0
	     result = 0.0
	     (0..100).each do |k|
	     	# Calculate C sub k
		if k > 1 then 
		   c[k] = 0.0
		   (0..(k-1)).each do |m|
			term = (c[m]*c[k-1.0-m])/((m+1.0)*(2.0*m+1.0))
			c[k] += term
		    end
		end
		result += (c[k]/(2.0*k+1))*((Math.sqrt(Math::PI)/2)*x)**(2.0*k+1)
	     end
	     return result
	 end 

       ##
       # Provides gamma function if not defined by ruby
       #
       unless method_defined? :gamma then
       	 def self.gamma(z)
   	      if z.real < 0.5
              	 PI / (sin(PI*z)*gamma(1-z))
    	      else
		 z -= 1
        	 x = Lanczos_coef[0]
        	 for i in 1..G+1
            	     x += Lanczos_coef[i]/(z+i)
        	 end
        	 t = z + G + 0.5
        	 sqrt(2*PI) * t**(z+0.5) * exp(-t) * x
	       end
        end
       end
end
	      

module Rsquared
  ##
  # The Dists module implements statistical functions directly
  # For use by experts only
  # = Example
  #
  # Rsquared::Dists::normalcdf(0, 1**99) => 0.5
  #
  module Dists
  	 ##
	 # normalcdf(lower bound, upper bound) => Float
         # Returns area under standard normal curve between supplied values
         #
  	 def normalcdf(lowerz, upperz)
		upperarea = 0.5*(1+Math.erf(upperz/Math.sqrt(2)))
		lowerarea = 0.5*(1+Math.erf(lowerz/Math.sqrt(2)))
		upperarea - lowerarea
         end


	 ##
	 # normalpdf(x) => Float
	 # Returns height of standard normal curve at x
         #
	 def normalpdf(zscore)
		Math.exp((-zscore**2)/2.0)/Math.sqrt(2*Math::PI)
	 end

	 ##
	 # invNorm(x) => Float
	 # Useful results when -1 < x < 1
	 # Returns z-score of supplied probability x
	 #
	 def invNorm(x)
	     return -1e99 if x <= -1.0
	     return 1e99 if x >= 1.0
 	     Math.sqrt(2)*Math.invErf(2*x-1)
	 end 

	 ##
	 # tpdf(x, df) => Float
	 # Returns height of Student's t-distribution for given x and degrees of freedom
	 #
	 def tpdf(x, df)
	     (Math.gamma((df+1.0)/2.0)/(Math.sqrt(df*Math::PI)*Math.gamma(df/2.0)))*(1.0+(x**2)/df.to_f)**(-(df+1.0)/2.0)
	 end

	 ##
	 # tcdf(tscore, df, twosided=false) => Float
	 # Returns the area under Student's t-distribution between supplied value and INF. Value is multiplied by 2 if twosided is true.
         #

	 def tcdf(tscore, df, twosided=false)
	     if tscore**2 > df then
	     	return 0.0
	     end
	     pvalue = 0.5 - tscore.abs*(Math.gamma(0.5*(df+1.0))/(Math.sqrt(Math::PI*df)*Math.gamma(df/2.0)))*Math.hypergeom(0.5, 0.5*(df+1.0), 3.0/2.0, -(tscore**2/df.to_f))
	     if twosided then
	     	return 2*pvalue
	     else
		return pvalue
	     end
	 end

	 ##
	 # chicdf(chi, df) => Float
	 # Returns the area in the upper tail of the chi-squared distribution with given degrees of freedom
	 #

	 def chicdf(chi, df)
	     1-(Math.incompleteGamma(df/2.0, chi/2.0)/Math.gamma(df/2.0))
	 end


	 ##
	 # chipdf(x, df) => Float
	 # Returns the height of the chi-squared distribution with specified degrees of freedom at value x
	 #
	 
	 def chipdf(x, df)
	     ((x**(df/2.0-1))*Math.exp(-x/2.0))/((2**(df/2.0))*Math.gamma(df/2.0))
	 end
	 
	 module_function :normalcdf, :normalpdf, :invNorm, :tpdf, :tcdf, :chicdf, :chipdf
  end
end
