`timescale 1ns/1ps

module gpio_control_tb;

reg clk;
reg reset;
reg write_en;
reg read_en;
reg [31:0] addr;
reg [31:0] wdata;
reg [31:0] gpio_in;

wire [31:0] rdata;
wire [31:0] gpio_out;

gpio_control_ip dut(
    .clk(clk),
    .reset(reset),
    .write_en(write_en),
    .read_en(read_en),
    .addr(addr),
    .wdata(wdata),
    .gpio_in(gpio_in),
    .rdata(rdata),
    .gpio_out(gpio_out)
);

always #5 clk = ~clk;

initial
begin
$dumpfile("gpio3.vcd");
$dumpvars(0,gpio_control_tb);

clk = 0;
reset = 1;
write_en = 0;
read_en = 0;

#10 reset = 0;

#10
write_en = 1;
addr = 32'h04;
wdata = 32'hFF;

#10
addr = 32'h00;
wdata = 32'hAA;

#10
write_en = 0;
read_en = 1;
addr = 32'h08;

#20 $finish;

end

endmodule
