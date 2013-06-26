module Enumerable
       def sum
       	   return self.inject(0){|acc, i| acc+i}
       end

       def mean
       	   return self.sum/self.length.to_f
       end

       def variance
       	   varsum = self.inject(0){|acc, i| acc + (i - self.mean)**2}
	   return(varsum/self.length.to_f)
       end

       def stddev
       	   return Math.sqrt(self.variance)
       end

       def skew
       	   thirdsum = self.inject(0){|acc, i| acc + (i - self.mean)**3}
	   thirdmoment = thirdsum/self.length.to_f
	   return thirdmoment / (self.variance)**(3.0/2.0)
       end

       def kurtosis
       	   fourthsum = self.inject(0){|acc, i| acc + (i - self.mean)**4}
	   fourthmoment = fourthsum/self.length.to_f
	   return fourthmoment / (self.variance)**2
       end
end