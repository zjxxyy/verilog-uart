/*

Copyright (c) 2014 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`timescale 1 ns / 1 ps

module test_uart_rx;

// Inputs
reg clk = 0;
reg rst = 0;
reg [7:0] current_test = 0;

reg output_axi_tready = 0;
reg rxd = 1;
reg [15:0] prescale = 0;

// Outputs
wire [7:0] output_axi_tdata;
wire output_axi_tvalid;

wire busy;
wire overrun_error;
wire frame_error;

initial begin
    // myhdl integration
    $from_myhdl(clk,
                rst,
                current_test,
                output_axi_tready,
                rxd,
                prescale);
    $to_myhdl(output_axi_tdata,
              output_axi_tvalid,
              busy,
              overrun_error,
              frame_error);

    // dump file
    $dumpfile("test_uart_rx.lxt");
    $dumpvars(0, test_uart_rx);
end

uart_rx #(
    .DATA_WIDTH(8)
)
UUT (
    .clk(clk),
    .rst(rst),
    // axi output
    .output_axi_tdata(output_axi_tdata),
    .output_axi_tvalid(output_axi_tvalid),
    .output_axi_tready(output_axi_tready),
    // input
    .rxd(rxd),
    // status
    .busy(busy),
    .overrun_error(overrun_error),
    .frame_error(frame_error),
    // configuration
    .prescale(prescale)
);

endmodule
