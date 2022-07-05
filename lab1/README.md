程式目的：

3個加法器累加4個4-bit輸入



執行方式：

對程式進行編譯並產生檔案
//iverilog [-o filename] source_file(s)
iverilog  –o  dio  testbench_add2.v add2.v

執行程式觀察結果
//vvp  input-file
vvp  dio