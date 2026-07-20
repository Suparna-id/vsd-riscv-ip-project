module spi_master (
         input wire clk,
         input wire rst_n,
         input wire start,
         input wire [7:0] tx_data,
         output reg mosi,
         output reg cs_n,
         output reg ready
);

localparam state_idle     = 2'b00;
localparam state_transfer = 2'b01;
localparam state_done     = 2'b10;

reg [1:0] current_state, next_state;
reg [7:0] shift_reg;
reg [2:0] bit_counter;

always @(posedge clk or negedge rst_n) begin
if(!rst_n) 
current_state <= state_idle;
else
current_state <= next_state;
end

always @(*) begin
   next_state = current_state;
   case(current_state)
       state_idle: begin
          if (start) next_state = state_transfer;
          end
            state_transfer: begin  
              if (bit_counter == 3'd7) next_state = state_done;
              end

               state_done: begin  next_state = state_idle;
               end
    endcase
    end

always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin 
           shift_reg   <= 8'd0;
           bit_counter <= 3'd0;
           mosi        <= 1'b0;
           cs_n        <= 1'b1;
           ready       <= 1'b1;
    end else begin 
         case(current_state)
           state_idle: begin
          cs_n    <= 1'b1;
          ready   <= 1'b1;
          mosi    <= 1'b0;
          if (start) begin
          shift_reg    <=  tx_data;
          bit_counter  <=  3'd0;
          cs_n         <=  1'b0;
          ready        <=  1'b0;
          end
    end
    state_transfer: begin
    mosi         <= shift_reg[7];
    shift_reg    <= {shift_reg[6:0], 1'b0};
    bit_counter  <= bit_counter + 1'b1;
    end
    state_done: begin
      cs_n     <= 1'b1;
      ready    <= 1'b1;
      mosi     <= 1'b0;               
      end
      endcase
    end
end
endmodule          
