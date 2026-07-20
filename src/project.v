/*
 * Copyright (c) 2026 nguyenvandongsn97-sys
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_nguyenvandongsn97_sys_full_adder (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs

    input  wire [7:0] uio_in,   // Bidirectional input path
    output wire [7:0] uio_out,  // Bidirectional output path
    output wire [7:0] uio_oe,   // Bidirectional output enable

    input  wire ena,            // Enabled when the project is selected
    input  wire clk,            // Unused: combinational design
    input  wire rst_n           // Unused: combinational design
);

    wire a;
    wire b;
    wire cin;
    wire sum_bit;
    wire cout_bit;

    assign a   = ui_in[0];
    assign b   = ui_in[1];
    assign cin = ui_in[2];

    // One-bit full-adder equations
    assign sum_bit  = a ^ b ^ cin;
    assign cout_bit = (a & b) | (a & cin) | (b & cin);

    // uo_out[0] = Sum
    // uo_out[1] = Cout
    assign uo_out = {6'b000000, cout_bit, sum_bit};

    // Bidirectional pins are not used
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Reference all unused inputs to avoid lint warnings
    wire _unused = &{
        ena,
        clk,
        rst_n,
        ui_in[7:3],
        uio_in,
        1'b0
    };

endmodule

`default_nettype wire
