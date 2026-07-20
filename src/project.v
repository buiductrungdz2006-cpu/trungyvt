/*
 * Copyright (c) 2026 Tên Của Bạn
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_my_counter (
    input  wire [7:0] ui_in,    // Các chân đầu vào cố định
    output wire [7:0] uo_out,   // Các chân đầu ra cố định
    input  wire [7:0] uio_in,   // Các chân I/O (dữ liệu vào)
    output wire [7:0] uio_out,  // Các chân I/O (dữ liệu ra)
    output wire [7:0] uio_oe,   // Chân cho phép I/O (1 = Output, 0 = Input)
    input  wire       ena,      // Tín hiệu enable toàn cục (luôn bằng 1 khi có điện)
    input  wire       clk,      // Xung nhịp (Clock)
    input  wire       rst_n     // Reset tích cực mức thấp (Low = Reset)
);

    // Bắt buộc: Gán giá trị cho tất cả các chân output, kể cả khi không dùng.
    // Ở đây, ta cấu hình bộ chân uio thành input bằng cách gán uio_oe = 0.
    assign uio_oe  = 8'b00000000;
    assign uio_out = 8'b00000000;

    // Sử dụng chân ui_in[0] làm nút công tắc bật/tắt bộ đếm
    wire enable = ui_in[0];

    // Khai báo một thanh ghi (register) 8-bit để lưu giá trị đếm
    reg [7:0] counter;

    // Khối logic tuần tự hoạt động theo sườn dương của xung clock
    always @(posedge clk) begin
        if (!rst_n) begin
            // Nếu có tín hiệu reset (kéo xuống mức thấp), đưa bộ đếm về 0
            counter <= 8'b00000000;
        end else if (enable) begin
            // Nếu chân ui_in[0] được bật, tăng bộ đếm thêm 1
            counter <= counter + 1;
        end
    end

    // Xuất giá trị của thanh ghi counter ra các chân output uo_out
    assign uo_out = counter;

endmodule
