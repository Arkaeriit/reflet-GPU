/*----------------------\
|This module delays a   |
|signal by a defined    |
|number of clock cycles.|
\----------------------*/

module reflet_delay #(
    parameter delay = 2
    )(
    input clk,
    input enable,
    input in,
    output out
    );

    reg shift_register [delay-1:0];
    assign out = shift_register[delay-1];
    integer i;

    always @ (posedge clk)
        if (enable)
        begin
            shift_register[0] <= in;
            for (i=1; i<delay; i=i+1)
                shift_register[i] <= shift_register[i-1];
        end

endmodule
