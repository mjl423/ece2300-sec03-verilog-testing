PairTripleDetector_GL-test : ptd/PairTripleDetector_GL.v ptd/test/PairTripleDetector_GL-test.v
	verilator -Wall --lint-only ptd/PairTripleDetector_GL.v
	iverilog -Wall -g2012 -o PairTripleDetector_GL-test ptd/test/PairTripleDetector_GL-test.v

clean:
	rm -rf PairTripleDetector_GL-test