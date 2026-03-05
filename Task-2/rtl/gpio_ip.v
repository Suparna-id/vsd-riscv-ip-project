module gpio_ip(
    input clk,
    input reset,

    input write_en,
    input read_en,

    input [31:0] wdata,
    output reg [31:0] rdata,

    output [31:0] gpio_out
);

reg [31:0] gpio_reg;

always @(posedge clk or posedge reset)
begin
    if(reset)
        gpio_reg <= 32'b0;
    else if(write_en)
        gpio_reg <= wdata;
end

assign gpio_out = gpio_reg;

always @(*)
begin
    if(read_en)
        rdata = gpio_reg;
    else
        rdata = 32'b0;
end

endmodule
