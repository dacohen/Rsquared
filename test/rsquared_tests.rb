require 'test/unit'
require 'rsquared'

module Test::Unit::Assertions
       def refute(bool, *rest)
       	   assert(!bool, *rest)
       end
end

$data = [-105, 135, 40, 90, -55, -85, 70, 180, 140, -10, -105, 40, 185, -90, -90, 80, 70, -155, 345, 250, 10, -135, 80, 85, -40, 250, -20, 35, 305, -135]

class RsquaredTests < Test::Unit::TestCase

      def test_KS
	  kstest = Rsquared::KSTest.new($data)	  
      	  assert_in_delta 0.1046877, kstest.statistic, 0.001
	  assert kstest.normal?
      end

      def test_Grubbs
      	  grubbs = Rsquared::GrubbsTest.new($data)
	  assert_in_delta 2.21, grubbs.statistic, 0.01
	  refute grubbs.significant?
	  refute grubbs.outlier?

	  data = $data + [800]
	  grubbs = Rsquared::GrubbsTest.new(data)
	  assert grubbs.significant?
	  assert grubbs.outlier?
      end
end