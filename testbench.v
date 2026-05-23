module prime_detector_testbench;

  	reg [3:0] N_testbench;
    wire P_testbench;
    integer i;

  	prime_detector prime_test (.N(N_testbench), .P(P_testbench));

  	initial begin
		$dumpfile("dump.vcd");
      	$dumpvars;

      	$display("-------------------------------------------------------");
      	$display(" time (ns) | 		input  		| Decimal  | Prime?");
      	$display("-------------------------------------------------------");
      	$monitor("   %4d     |       %4b        |   %2d    |      %b", 
               		$time, N_testbench, N_testbench, P_testbench);

      for (i = 0; i < 16; i = i + 1) begin
        	N_testbench = i;
        	#10;
      	end

      	#10;

      	$finish;
    end

endmodule