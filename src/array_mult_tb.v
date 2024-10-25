`timescale 1ns / 1ps

module array_mult_tb;

// Inputs
reg [3:0] m = 4'b0000;
reg [3:0] q = 4'b0000;

// Outputs
wire [7:0] p_struct;
wire [7:0] p_generate;

// Reference
reg [7:0] p_ref = 8'b00000000;
integer failures = 0;

// Instantiate structural multiplier
array_mult_structural dut_struct(
	.m(m),
	.q(q),
	.p(p_struct)
);


// Stimulus
initial begin
	// Initialize Inputs
	m = 4'b0000;
	q = 4'b0000;

	// Wait 10ns for global reset to finish
	#10;

	// Test 1
	m = 4'b0001;
	q = 4'b0001;
	p_ref = 8'b00000001;
	#10;

	// Test 2
	m = 4'b0010;
	q = 4'b0010;
	p_ref = 8'b00000100;
	#10;

	// Test 3
	m = 4'b0001;
	q = 4'b0100;
	p_ref = 8'b00000100;
	#10;

	// Test 4
	m = 4'b1000;
	q = 4'b1000;
	p_ref = 8'b01000000;
	#10;

	// Test 5
	m = 4'b1111;
	q = 4'b1111;
	p_ref = 8'b11100001;
	#10;

	// Test 6
	m = 4'b0000;
	q = 4'b0110;
	p_ref = 8'b00000000;
	#10;

	// Test 7
	m = 4'b0010;
	q = 4'b1000;
	p_ref = 8'b00010000;
	#10;

	// Test 8
	m = 4'b1001;
	q = 4'b0101;
	p_ref = 8'b00101101;
	#10;

	// Test 9
	m = 4'b1111;
	q = 4'b0001;
	p_ref = 8'b00001111;
	#10;

	// Test 10
	m = 4'b0000;
	q = 4'b0000;
	p_ref = 8'b00000000;
	#10;

	// End of test

	// Reporting
	if (failures === 0) begin
		$display("All tests passed");
	end else begin
		$display("%d tests failed", failures);
	end
	$finish;
end

// Evaluation
always @(*) begin
	if (p_struct !== p_ref) begin
		$display("Error: p_struct = %b, p_ref = %b", p_struct, p_ref);
		failures = failures + 1;
	end
	if (p_generate !== p_ref) begin
		$display("Error: p_generate = %b, p_ref = %b", p_generate, p_ref);
		failures = failures + 1;
	end
end

endmodule
