call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"
mkdir "D:\app ideas\MentalBreak\peqsourcecode-main\build_nmake"
cd "D:\app ideas\MentalBreak\peqsourcecode-main\build_nmake"
cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release ..
nmake zone
copy /Y "D:\app ideas\MentalBreak\peqsourcecode-main\build_nmake\zone\zone.exe" "D:\app ideas\MentalBreak\eqemu server\eqemu\zone.exe"
