module spi_led_control (
    input wire clk,         // System clock
    input wire reset,       // System reset
    input wire sclk,        // SPI clock
    input wire cs,          // Chip select (active low)
    input wire mosi,        // Master Out Slave In (data from ESP32)
    output wire miso,       // Master In Slave Out (data to ESP32)
    output reg led          // LED output
);

    reg [7:0] shift_reg;    // Shift register for SPI
    reg [2:0] bit_count;    // Counter for received bits
    reg data_received;      // Flag indicating data reception

    assign miso = shift_reg[7]; // Output the MSB of the shift register

    always @(posedge sclk or posedge reset) begin
        if (reset) begin
            shift_reg <= 8'b0;
            bit_count <= 3'b0;
            data_received <= 0;
        end else if (!cs) begin
            // Shift in data from MOSI
            shift_reg <= {shift_reg[6:0], mosi};
            bit_count <= bit_count + 1;

            // If 8 bits are received, set the data received flag
            if (bit_count == 3'b111) begin
                data_received <= 1;
            end
        end else begin
            bit_count <= 3'b0; // Reset bit count when CS is high
            data_received <= 0;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            led <= 0;
        end else if (data_received) begin
            if (shift_reg == 8'h31) begin // ASCII '1'
                led <= 1; // Turn on LED
            end else if (shift_reg == 8'h30) begin // ASCII '0'
                led <= 0; // Turn off LED
            end
        end
    end
endmodule
