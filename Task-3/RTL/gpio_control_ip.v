module gpio_control_ip (
    input clk,
    input reset,
    input write_en,
    input read_en,
    input [31:0] addr,
    input [31:0] wdata,
    input [31:0] gpio_in,
    output reg [31:0] rdata,
    output [31:0] gpio_out
);

reg [31:0] gpio_data;
reg [31:0] gpio_dir;

assign gpio_out = gpio_data;

always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
        gpio_data <= 32'b0;
        gpio_dir  <= 32'b0;
    end
    else if (write_en)
    begin
        case(addr)
            32'h00: gpio_data <= wdata;
            32'h04: gpio_dir  <= wdata;
        endcase
    end
end

always @(*)
begin
    if(read_en)
    begin
        case(addr)
            32'h00: rdata = gpio_data;
            32'h04: rdata = gpio_dir;
            32'h08: rdata = (gpio_dir & gpio_data) | (~gpio_dir & gpio_in);
            default: rdata = 32'b0;
        endcase
    end
end

endmodule
