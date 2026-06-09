@echo ON

cmake -B build/ ^
    -G "Ninja" ^
    -D CMAKE_BUILD_TYPE=Release ^
    -D SPARROW_IPC_BUILD_SHARED=ON ^
    -D SPARROW_IPC_BUILD_TESTS=OFF ^
    -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    %SRC_DIR%

if errorlevel 1 exit 1
cmake --build build/ --parallel %CPU_COUNT%
if errorlevel 1 exit 1
cmake --install build/
if errorlevel 1 exit 1

REM TODO: remove this when it has been fixed upstream
REM Remove flatbuffers generated headers (implementation detail, not part of public API)
rd /s /q "%PREFIX%\Library\include\sparrow_ipc\flatbuffers_generated"
if errorlevel 1 exit 1
