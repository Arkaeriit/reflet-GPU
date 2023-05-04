/*
* This module multiplicate two n-bit numbers in n clock cycle.
* The multiplication are pipelined so a new number can be given each clock
* cycle
*/

module slow_multiplication #(
    parameter size = 16
    )(
    input clk,
    input enable,
    input [size-1:0] in_1,
    input [size-1:0] in_2,
    output [size*2-1:0] out
    );

    reg [size*2-1:0] tmp_result [size-1:0];    
    reg [size*2-1:0] in_1_history [size-1:0];    
    reg [size*2-1:0] in_2_sift [size-1:0];    

    integer i;

    always @ (posedge clk)
        if (enable)
        begin
            in_1_history[0] <= in_1;
            in_2_sift[0] <= in_2;
            tmp_result[0] <= in_2[0] ? in_1 : 0;
            for (i=0; i<size; i=i+1)
            begin
                in_2_sift[i] <= in_2_sift[i-1] >> 1; 
            end
        end

endmodule

