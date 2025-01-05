# SPI Chip Select (CS) -> GPIO30
set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS33} [get_ports cs]

# SPI Clock (SCLK) -> GPIO31
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports sclk]

# SPI Master Out Slave In (MOSI) -> GPIO32
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports mosi]

# SPI Master In Slave Out (MISO) -> GPIO33
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports miso]

# LED Output Pin
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports led]

# Clock Input Pin (50 MHz clock example, adjust as per your board)
set_property -dict {PACKAGE_PIN C8 IOSTANDARD LVCMOS33} [get_ports clk]

# Reset Input Pin (connect to a button or use a default value)
set_property -dict {PACKAGE_PIN D9 IOSTANDARD LVCMOS33} [get_ports reset]
