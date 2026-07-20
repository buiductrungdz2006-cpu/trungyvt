## How it works

This project implements a combinational one-bit full adder.

The three input bits are:

- `ui_in[0]`: A
- `ui_in[1]`: B
- `ui_in[2]`: Cin

The two output bits are:

- `uo_out[0]`: Sum
- `uo_out[1]`: Cout

The logic equations are:

`Sum = A XOR B XOR Cin`

`Cout = (A AND B) OR (A AND Cin) OR (B AND Cin)`

The clock and reset inputs are not used because this is a purely
combinational circuit.

## How to test

Apply A, B, and Cin through `ui_in[2:0]`, then read Sum and Cout from
`uo_out[1:0]`.

| A | B | Cin | Sum | Cout |
|---|---|-----|-----|------|
| 0 | 0 | 0   | 0   | 0    |
| 0 | 0 | 1   | 1   | 0    |
| 0 | 1 | 0   | 1   | 0    |
| 0 | 1 | 1   | 0   | 1    |
| 1 | 0 | 0   | 1   | 0    |
| 1 | 0 | 1   | 0   | 1    |
| 1 | 1 | 0   | 0   | 1    |
| 1 | 1 | 1   | 1   | 1    |

## External hardware

No external hardware is required.
