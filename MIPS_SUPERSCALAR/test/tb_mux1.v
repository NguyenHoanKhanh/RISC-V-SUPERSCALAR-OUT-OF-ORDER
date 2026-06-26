`include "./source/mux.v"
`timescale 1ns / 1ps

module tb_mux;

    // 1. Khai báo tín hiệu
    reg a, b, c;    // Input là reg để gán giá trị
    wire d, e;      // Output là wire để quan sát

    // 2. Kết nối với module chính (DUT - Device Under Test)
    mux uut (
        .a(a), 
        .b(b), 
        .c(c), 
        .d(d), 
        .e(e)
    );

    // 3. Chạy kịch bản test
    initial begin
        // Hiển thị kết quả ra màn hình console mỗi khi tín hiệu thay đổi
        $monitor("Time=%0t | a=%b b=%b c=%b | Output d=%b | Output e=%b", 
                 $time, a, b, c, d, e);

        // --- Trường hợp 1: a = 0 (d và e phải bằng 0 bất kể b, c) ---
        a = 0; b = 0; c = 0; #10;
        a = 0; b = 1; c = 0; #10;
        a = 0; b = 0; c = 1; #10;
        a = 0; b = 1; c = 1; #10;

        // --- Trường hợp 2: a = 1 (d và e phải bằng 1 bất kể b, c) ---
        a = 1; b = 0; c = 0; #10; // Test logic (a=1 && b=0) -> d=1
        a = 1; b = 1; c = 0; #10; // Test logic (a=1 && b=1) -> d=1
        a = 1; b = 0; c = 1; #10; 
        a = 1; b = 1; c = 1; #10;

        // Kết thúc mô phỏng
        $finish;
    end

endmodule