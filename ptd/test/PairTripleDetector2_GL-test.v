//========================================================================
// PairTripleDetector2_GL-test
//========================================================================

`include "ece2300/ece2300-test.v"
`include "ptd/PairTripleDetector2_GL.v"

module Top();

  //----------------------------------------------------------------------
  // Setup
  //----------------------------------------------------------------------

  TestUtils t();

  //----------------------------------------------------------------------
  // Instantiate design under test
  //----------------------------------------------------------------------

  logic [2:0] a;
  logic [2:0] b;
  logic       out;

  PairTripleDetector2_GL dut
  (
    .a   (a),
    .b   (b),
    .out (out)
  );

  //----------------------------------------------------------------------
  // check
  //----------------------------------------------------------------------
  // All tasks start at #1 after the rising edge of the clock. So we
  // write the inputs #1 after the rising edge, and check the outputs #1
  // before the next rising edge.

  task check
  (
    input logic [2:0] a_,
    input logic [2:0] b_,
    input logic       out_
  );
    if ( !t.failed ) begin
      t.num_checks += 1;

      #1;

      a = a_;
      b = b_;

      #8;

      if ( t.n != 0 )
        $display( "%3d: %b %b > %b", t.cycles, a, b, out );

      `ECE2300_CHECK_EQ( out, out_ );

      #1;

    end
  endtask

    logic [2:0] random_a;
  logic [2:0] random_b;
  logic       random_out;
  int         random_a_num_ones;
  int         random_b_num_ones;

  task test_case_4_random();
    t.test_case_begin( "test_case_4_random" );

    // Generate 20 random input values

    for ( int i = 0; i < 20; i = i+1 ) begin

      // Generate a 3-bit random value for both a and b

      random_a = 3'($urandom(t.seed));
      random_b = 3'($urandom(t.seed));

      // Calculate the number of ones in random value a

      random_a_num_ones = 0;
      for ( int j = 0; j < 3; j = j+1 ) begin
        if ( random_a[j] )
          random_a_num_ones = random_a_num_ones + 1;
      end

      // Calculate the number of ones in random value b

      random_b_num_ones = 0;
      for ( int j = 0; j < 3; j = j+1 ) begin
        if ( random_b[j] )
          random_b_num_ones = random_b_num_ones + 1;
      end

      // Calculate the correct output value

      random_out = (random_a_num_ones > 1) || (random_b_num_ones > 1);

      // Apply the random input values and check the output value

      check( random_a, random_b, random_out );

    end

    t.test_case_end();
  endtask
  //----------------------------------------------------------------------
  // test_case_1_basic
  //----------------------------------------------------------------------

  task test_case_1_basic();
    t.test_case_begin( "test_case_1_basic" );

    //     a       b       out
    check( 3'b000, 3'b000, 0 );
    check( 3'b011, 3'b011, 1 );

    t.test_case_end();
  endtask

  //----------------------------------------------------------------------
  // test_case_2_many_ones
  //----------------------------------------------------------------------

  task test_case_2_many_ones();
    t.test_case_begin( "test_case_2_many_ones" );

    //     a       b       out
    check( 3'b001, 3'b011, 1 );
    check( 3'b010, 3'b011, 1 );
    check( 3'b100, 3'b011, 1 );
    check( 3'b011, 3'b001, 1 );
    check( 3'b011, 3'b010, 1 );
    check( 3'b011, 3'b100, 1 );
    check( 3'b011, 3'b011, 1 );
    check( 3'b110, 3'b110, 1 );
    check( 3'b101, 3'b101, 1 );
    check( 3'b111, 3'b111, 1 );

    t.test_case_end();
  endtask

  //----------------------------------------------------------------------
  // test_case_3_few_ones
  //----------------------------------------------------------------------

  task test_case_3_few_ones();
    t.test_case_begin( "test_case_3_few_ones" );

    //     a       b       out
    check( 3'b001, 3'b001, 0 );
    check( 3'b010, 3'b001, 0 );
    check( 3'b100, 3'b001, 0 );
    check( 3'b010, 3'b001, 0 );
    check( 3'b010, 3'b010, 0 );
    check( 3'b010, 3'b100, 0 );

    t.test_case_end();
  endtask

  //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Add new test case for random testing
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  //----------------------------------------------------------------------
  // main
  //----------------------------------------------------------------------

  initial begin
    t.test_bench_begin();

    if ((t.n <= 0) || (t.n == 1)) test_case_1_basic();
    if ((t.n <= 0) || (t.n == 2)) test_case_2_many_ones();
    if ((t.n <= 0) || (t.n == 3)) test_case_3_few_ones();
    if ((t.n <= 0) || (t.n == 4)) test_case_4_random();

    //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // Add new test case for random testing to the list of test cases
    //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    t.test_bench_end();
  end

endmodule

