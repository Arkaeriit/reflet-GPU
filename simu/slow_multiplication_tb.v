/*------------------------------------\
|This module tests the slow           |
|multiplication module by simply      |
|feeding it numbers and waiting a bit.|
\------------------------------------*/

module slow_multiplication_tb ();

    reg clk = 0;
    always #1 clk = !clk;

    reg [5:0] in_1;
    reg [5:0] in_2;
    wire [11:0] out;

    slow_multiplication #(6) mult (
        .clk(clk),
        .enable(1'b1),
        .in_1(in_1),
        .in_2(in_2),
        .out(out));

    integer i;

    initial
    begin
        $dumpfile("slow_multiplication_tb.vcd");
        $dumpvars(0, slow_multiplication_tb);
        for(i = 0; i<5; i=i+1)
        begin
            $dumpvars(0, mult.in_1_shift[i]);
            $dumpvars(0, mult.in_2_shift[i]);
            $dumpvars(0, mult.tmp_result[i]);
        end
        #10;
        in_1 = 1;
        in_2 = 10;
        #20;
        in_1 = 10;
        in_2 = 12;
        #20;
        in_1 = 60;
        in_2 = 40;
        #20;
        $finish;
    end

endmodule

