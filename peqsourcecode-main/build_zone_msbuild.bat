call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"
cd "D:\app ideas\MentalBreak\peqsourcecode-main\build"
del /q /s CMakeCache.txt CMakeFiles
cmake -G "Visual Studio 17 2022" -A x64 ..
msbuild EQEmu.sln /m /p:Configuration=Release /t:zone
