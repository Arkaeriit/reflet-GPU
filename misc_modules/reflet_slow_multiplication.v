/*------------------------------------\
|This module multiplicate two n-bit   |
|numbers in n clock cycle. The        |
|multiplication are pipelined so a new|
|number can be given each clock cycle.|
\------------------------------------*/

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
    reg [size*2-1:0] in_1_shift [size-2:0];    
    reg [size-1:0] in_2_shift [size-2:0];    

    integer i;

    always @ (posedge clk)
        if (enable)
        begin
            in_1_shift[0] <= in_1 << 1;
            in_2_shift[0] <= in_2 >> 1;
            tmp_result[0] <= in_2[0] ? in_1 : 0;
            for (i=1; i<size-1; i=i+1)
            begin
                in_1_shift[i] <= in_1_shift[i-1] << 1;
                in_2_shift[i] <= in_2_shift[i-1] >> 1; 
                tmp_result[i] <= tmp_result[i-1] + (in_2_shift[i-1][0] ? in_1_shift[i-1] : 0);
            end
            tmp_result[size-1] = tmp_result[size-2] + (in_2_shift[size-2][0] ? in_1_shift[size-2] : 0);
        end

    assign out = tmp_result[size-1];

endmodule

