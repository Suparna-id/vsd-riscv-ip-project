module gpio_ip (
    input  wire        clk,
    input  wire        rst_n,

    // Bus interface
    input  wire        bus_valid,
    input  wire        bus_we,
    input  wire [31:0] bus_addr,
    input  wire [31:0] bus_wdata,
    output reg  [31:0] bus_rdata,

    // GPIO output
    output reg  [31:0] gpio_out
);

    // Register offset
    localparam GPIO_DATA_OFFSET = 32'h00;

    // Write logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            gpio_out <= 32'h0;
        end else if (bus_valid && bus_we &&
                     bus_addr[7:0] == GPIO_DATA_OFFSET) begin
            gpio_out <= bus_wdata;
        end
    end

    // Read logic
    always @(*) begin
        if (bus_valid && !bus_we &&
            bus_addr[7:0] == GPIO_DATA_OFFSET)
            bus_rdata = gpio_out;
        else
            bus_rdata = 32'h0;
    end

endmodule
