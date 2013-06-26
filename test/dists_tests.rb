require 'test/unit'
require 'rsquared'

class DistsTest < Test::Unit::TestCase
      def test_normalcdf
      	  assert_in_delta 0.5, Rsquared::Dists::normalcdf(0, 1e99), 0.001
      end
      
      def test_normalpdf
      	  assert_in_delta 0.00443, Rsquared::Dists::normalpdf(3), 0.001
      end
      
      def test_invNorm
      	  assert_in_delta 0.6744897, Rsquared::Dists::invNorm(0.75), 0.001
	  	  assert_in_delta 1e99, Rsquared::Dists::invNorm(1.001), 0.001
	  	  assert_in_delta -1e99, Rsquared::Dists::invNorm(-1.001), 0.001
      end

      def test_tpdf
      	  assert_in_delta 0.06114577, Rsquared::Dists::tpdf(2, 10), 0.001
      end

      def test_tcdf
      	  assert_in_delta 0, Rsquared::Dists::tcdf(3.17, 10), 0.001
	  	  assert_in_delta 0.0066718, Rsquared::Dists::tcdf(3, 10), 0.001
	  	  assert_in_delta 0.0133437, Rsquared::Dists::tcdf(3, 10, true), 0.001
      end

      def test_chipdf
      	  assert_in_delta 0.30326, Rsquared::Dists::chipdf(1, 2), 0.001
      end

      def test_chicdf
      	  assert_in_delta 0.6065307, Rsquared::Dists::chicdf(1, 2), 0.001
      end
end