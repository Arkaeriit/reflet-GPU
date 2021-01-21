/*--------------------------------------\
|This module codes for a N-bit ram block|
|with the different input and output    |
|addresses. Its behavior tries to mimic |
standard synchronous RAM.               |
\--------------------------------------*/

module reflet_ram #(
    parameter addrSize = 7,
    size = 128,
    depth = 8,
    resetable = 1
    )(
    input clk,
    input reset,
    input enable,
    input [addrSize-1:0] addr_read,
    input [addrSize-1:0] addr_write,
    input [depth-1:0] data_in,
    input write_en,
    output [7:0] data_out
    );
    integer i; //loop variable

	// Declare memory 
	reg [depth-1:0] memory_ram [size-1:0];
    reg [depth-1:0] data_out_array;

    //addr control
    wire usable_read = enable && addr_read < size && reset;
    wire usable_write = enable && addr_write < size && reset;

	generate
		if(|resetable)
		begin
			always @(posedge clk)
				if(!reset)
				  begin
					for (i=0;i<size; i=i+1)
						memory_ram[i] <= 0;
				  end
				else
				  begin
						if(usable_write && write_en)
							 memory_ram[addr_write] <= data_in;
						data_out_array <= memory_ram[addr_read];
				  end
		end
		else
		begin
			always @(posedge clk)
			  begin
					if(usable_write && write_en)
						 memory_ram[addr_write] <= data_in;
					data_out_array <= memory_ram[addr_read];
			  end
		end
	endgenerate
				 
    assign data_out = ( usable_read ? data_out_array : 0 );
        
endmodule

