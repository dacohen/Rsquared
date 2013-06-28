module Enumerable
       def sum
       	   return self.inject(0){|acc, i| acc+i}
       end

       def mean
       	   return self.sum/self.length.to_f
       end

       def variance
       	   varsum = self.inject(0){|acc, i| acc + (i - self.mean)**2}
	   return(varsum/(self.length.to_f-1.0))
       end

       def popvariance
       	   return self.variance*((self.length.to_f-1.0)/self.length.to_f)
       end

       def popstddev
       	   return Math.sqrt(self.popvariance)
       end

       def stddev
       	   return Math.sqrt(self.variance)
       end

       def skew
       	   thirdsum = self.inject(0){|acc, i| acc + (i - self.mean)**3}
	   thirdmoment = thirdsum/self.length.to_f
	   return thirdmoment / (self.popvariance)**(3.0/2.0)
       end

       def kurtosis
       	   fourthsum = self.inject(0){|acc, i| acc + (i - self.mean)**4}
	   fourthmoment = fourthsum/self.length.to_f
	   return (fourthmoment / (self.popvariance)**2)
       end

       def std
       	   result = []
       	   (0..self.length-1).each do |i|
	   	result[i] = (self[i] - self.mean)/self.stddev
	   end
	   return result
       end
end