程式目的：

4-operand adder 自動結果比對



執行方式：

對程式進行編譯並產生檔案
//iverilog [-o filename] source_file(s)
iverilog  –o  dio  testbench_add2.v add2.v

執行程式觀察結果
//vvp  input-file
vvp  dio

使用以下指令觀察波形
gtkwave add2.vcd