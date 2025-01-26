

module driver  #(parameter WIDTH = 8)
		(input wire  [WIDTH - 1 : 0] data_in, 
		 input wire  data_en,
	         output wire [WIDTH - 1: 0] data_out
		);

	assign data_out = (data_en == 1) ? data_in : 8'bz;

endmodule


