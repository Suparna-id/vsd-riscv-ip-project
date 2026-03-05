`timescale 1ns/1ps

module gpio_tb;

reg clk;
reg reset;
reg write_en;
reg read_en;
reg [31:0] wdata;

wire [31:0] rdata;
wire [31:0] gpio_out;

gpio_ip dut(
    .clk(clk),
    .reset(reset),
    .write_en(write_en),
    .read_en(read_en),
    .wdata(wdata),
    .rdata(rdata),
    .gpio_out(gpio_out)
);

always #5 clk = ~clk;

initial
begin

$dumpfile("gpio.vcd");
$dumpvars(0,gpio_tb);

clk = 0;
reset = 1;
write_en = 0;
read_en = 0;
wdata = 0;

#10 reset = 0;

#10 write_en = 1;
wdata = 32'h000000AA;

#10 write_en = 0;

#10 read_en = 1;

#10 read_en = 0;

#20 $finish;

end

endmodule
