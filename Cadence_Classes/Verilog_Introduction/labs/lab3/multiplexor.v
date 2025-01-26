module mux5 #(parameter width = 5)( 
	    input[width-1:0] in0,
       	    input[width-1:0] in1, 
	    input sel, 
	    output[width-1:0] mux_out
    	);
	assign mux_out = (sel == 1) ? in1 : in0;
endmodule
