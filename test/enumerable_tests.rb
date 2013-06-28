require 'test/unit'
require 'rsquared'

class EnumerableTest < Test::Unit::TestCase

      def test_sum
      	  assert_in_delta 15.0, [1,2,3,4,5].sum, 0.001
      end

      def test_mean
      	  assert_in_delta 3.0, [1,2,3,4,5].mean, 0.001
      end

      def test_variance
      	  assert_in_delta 2.5, [1,2,3,4,5].variance, 0.001
      end
      
      def test_stddev
      	  assert_in_delta 1.5811, [1,2,3,4,5].stddev, 0.001
      end

      def test_popvariance
      	  assert_in_delta 2.0, [1,2,3,4,5].popvariance, 0.001
      end
      
      def test_popstddev
      	  assert_in_delta 1.4142, [1,2,3,4,5].popstddev, 0.001
      end

      def test_skew
      	  assert_in_delta 0.0, [1,2,3,4,5].skew, 0.001
      end

      def test_kurtosis
      	  assert_in_delta 1.7, [1,2,3,4,5].kurtosis, 0.1
      end

      def test_std
      	  @checkvalues = [-1.2649, -0.63247, 0, 0.63257, 1.2649]
      	  [1,2,3,4,5].std.each_with_index do |x, i|
	  	assert_in_delta @checkvalues[i], x, 0.001
	  end
      end 
end