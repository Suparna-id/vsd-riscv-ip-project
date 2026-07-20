module clk_div #(parameter DIVISOR = 6 )(
    input wire clk_in,
    input wire rst_n,
    output reg clk_out
);

  reg [7:0] counter;

  always @(posedge clk_in or negedge rst_n) begin
    if (!rst_n) begin
     counter  <=  8'd0;
     clk_out  <=  1'b0;
      end else begin
       if (counter >= (DIVISOR -1 )) begin
        counter  <=  8'd0;
        clk_out  <= ~ clk_out;
        end else begin  
         counter <= counter + 1'b1;
         end
         end
         end
         endmodule