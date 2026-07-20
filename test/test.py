# SPDX-FileCopyrightText: © 2026 nguyenvandongsn97-sys
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_full_adder(dut):
    """Verify all eight input combinations of the one-bit full adder."""

    dut._log.info("Starting full-adder test")

    # Give all inputs known values.
    dut.ena.value = 1
    dut.clk.value = 0
    dut.rst_n.value = 1
    dut.uio_in.value = 0
    dut.ui_in.value = 0

    await Timer(10, unit="ns")

    for a in range(2):
        for b in range(2):
            for cin in range(2):
                # ui_in[0] = A, ui_in[1] = B, ui_in[2] = Cin
                dut.ui_in.value = a | (b << 1) | (cin << 2)

                # Allow RTL or gate-level combinational logic to settle.
                await Timer(10, unit="ns")

                total = a + b + cin
                expected_sum = total & 1
                expected_cout = (total >> 1) & 1

                output_value = int(dut.uo_out.value)
                actual_sum = output_value & 1
                actual_cout = (output_value >> 1) & 1

                dut._log.info(
                    "A=%d B=%d Cin=%d | Sum=%d Cout=%d",
                    a,
                    b,
                    cin,
                    actual_sum,
                    actual_cout,
                )

                assert actual_sum == expected_sum, (
                    f"Sum mismatch for A={a}, B={b}, Cin={cin}: "
                    f"expected {expected_sum}, got {actual_sum}"
                )
                assert actual_cout == expected_cout, (
                    f"Cout mismatch for A={a}, B={b}, Cin={cin}: "
                    f"expected {expected_cout}, got {actual_cout}"
                )

    # Check all unused outputs are tied low.
    assert (int(dut.uo_out.value) >> 2) == 0
    assert int(dut.uio_out.value) == 0
    assert int(dut.uio_oe.value) == 0

    dut._log.info("All eight full-adder combinations passed")
