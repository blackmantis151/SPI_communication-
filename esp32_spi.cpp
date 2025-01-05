#include <SPI.h>
#include <spartan-edge-esp32-boot.h>

// Instantiate the Spartan Edge boot class
spartan_edge_esp32_boot esp32Cla;

// Define the default bitstream file path on the SD card
#define LOADING_DEFAULT_FILE "/spi_led_control.bin"

// SPI Pin Definitions
#define CS_PIN 30   // GPIO30 -> FPGA CS
#define MOSI_PIN 32 // GPIO32 -> FPGA MOSI
#define MISO_PIN 33 // GPIO33 -> FPGA MISO
#define SCLK_PIN 31 // GPIO31 -> FPGA SCLK

void setup() {
  // Initialize USB Serial for communication with the PC
  Serial.begin(115200);
  Serial.println("Starting FPGA programming process...");

  // Initialize SPI
  SPI.begin(SCLK_PIN, MISO_PIN, MOSI_PIN, CS_PIN);
  pinMode(CS_PIN, OUTPUT);
  digitalWrite(CS_PIN, HIGH); // Deselect FPGA initially

  // Initialize the FPGA programming interface
  esp32Cla.begin();
  Serial.println("ESP32 initialized.");

  // Initialize FPGA GPIO for configuration
  esp32Cla.xfpgaGPIOInit();
  Serial.println("FPGA GPIO initialized.");

  // Load the FPGA bitstream from the SD card
  if (esp32Cla.xlibsSstream(LOADING_DEFAULT_FILE)) {
    Serial.println("Bitstream loaded successfully!");
  } else {
    Serial.println("Failed to load bitstream. Check file path and SD card.");
  }
}

void loop() {
  if (Serial.available()) {
    char data = Serial.read();  // Read input from PC terminal

    // Send data to FPGA via SPI
    digitalWrite(CS_PIN, LOW); // Select FPGA
    SPI.transfer(data);        // Transfer the data
    digitalWrite(CS_PIN, HIGH); // Deselect FPGA

    Serial.print("Sent to FPGA: ");
    Serial.println(data);
  }
}
