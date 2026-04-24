call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"
cd "D:\app ideas\MentalBreak\peqsourcecode-main\build"
del /q /s CMakeCache.txt CMakeFiles
cmake -A x64 ..
cmake --build . --config Release --target zone
copy /Y "D:\app ideas\MentalBreak\peqsourcecode-main\build\bin\Release\zone.exe" "D:\app ideas\MentalBreak\eqemu server\eqemu\zone.exe"
