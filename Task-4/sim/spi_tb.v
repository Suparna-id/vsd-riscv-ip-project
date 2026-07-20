`timescale 1ns/1ps

module spi_tb;

  reg clk_in;
  reg rst_n;
  reg start;
  reg [7:0] tx_data;

   wire  clk_out;
   wire  mosi;
   wire  cs_n;
   wire  ready;


   clk_div #(.DIVISOR(4)) u_clk_div (
                        .clk_in(clk_in),
                        .rst_n(rst_n),
                        .clk_out(clk_out)
                        );

    spi_master  u_spi_master (
                      .clk (clk_out),
                      .rst_n(rst_n),
                      .start(start),
                      .tx_data(tx_data),
                      .mosi(mosi),
                      .cs_n(cs_n),
                      .ready(ready)
    );

    always #41.5 clk_in = ~clk_in;

     initial begin 
      $dumpfile("spi_simulation.vcd");
      $dumpvars(0, spi_tb);
     
      clk_in  =  1'b0;
      rst_n   =  1'b0;
      start   =  1'b0;      
      tx_data =  8'h00;
      #50;
      rst_n  = 1'b1;
      tx_data  = 8'hAC;
      #10;
      start = 1'b1;
      #50;
      start   = 1'b0;
      
      wait(ready == 1'b1);
    
      #70;
      $display("simulation successfully completed!");
      $finish;
      
      end
      endmodule

                                   