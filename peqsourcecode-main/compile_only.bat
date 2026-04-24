call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"
cd "D:\app ideas\MentalBreak\peqsourcecode-main\build"
cmake --build . --config Release --target zone > compile_log.txt 2>&1
