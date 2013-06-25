require "Rsquared/version"
require "constants"
require 'complex'

module Math
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
  # The Raw module implements statistical functions directly
  # For use by experts only
  # = Example
  #
  # Rsquared::Raw::normalcdf(0, 1**99) => 0.5
  #
  module Raw
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
	 # tpdf(x, df) => Float
	 # Returns height of Student's t-distribution for given x and degrees of freedom
	 #
	 def tpdf(score, df)
	     (Math.gamma((df+1)/2.0)/(Math.sqrt(df*Math::PI)*Math.gamma(df/2.0)))*(1+(score**2/df))**(-(df+1)/2.0)
	 end

	 ##
	 # tcdf(tscore, df, twosided=false) => Float
	 # Returns the area under Student's t-distribution between supplied value and INF. Value is multiplied by 2 if twosided is true.
         #

	 def tcdf(tscore, df, twosided=false)
	     if tscore**2 > df then
	     	return 0
	     end
	     pvalue = 0.5 - tscore.abs*(Math.gamma(0.5*(df+1))/(Math.sqrt(Math::PI*df)*Math.gamma(df/2.0)))*Math.hypergeom(0.5, 0.5*(df+1), 3.0/2.0, -(tscore**2/df))
	     if twosided then
	     	return 2*pvalue
	     else
		return pvalue
	     end
	 end
	 
	 module_function :normalcdf, :normalpdf, :tpdf, :tcdf
  end
end
