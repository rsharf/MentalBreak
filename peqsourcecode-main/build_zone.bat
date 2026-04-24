call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"
cd "D:\app ideas\MentalBreak\peqsourcecode-main\build"
del /q /s CMakeCache.txt CMakeFiles
cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release ..
nmake zone
