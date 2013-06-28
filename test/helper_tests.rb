require 'test/unit'
require 'rsquared'

class HelperTest < Test::Unit::TestCase

      def test_kscv
      	        assert_equal 0.410, Rsquared::Helper::kscv(10)
	  	assert_equal 0.240, Rsquared::Helper::kscv(27)
	  	assert_in_delta 0.20273, Rsquared::Helper::kscv(45), 0.001
      end
      
end