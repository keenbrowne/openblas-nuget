## Packaging OpenBLAS for Nuget

To create a nuget package for OpenBLAS:

* Install the Powershell Community Extensions: 
https://pscx.codeplex.com/
* Install the CoApp tools: http://downloads.coapp.org/files/CoApp.Tools.Powershell.msi
* Install VS 2013.
* Run the build.ps1 PS script from the parent folder.

This will create a nuget package for OpenBLAS that can be used from VS or 
CMake.
CMake usage example:

In PS execute:
```PowerShell
PS> nuget install bonsai.openblas
```

Then in your CMakeLists.txt:
```CMake
cmake_minimum_required(VERSION 2.8.12)

project(test_openblas)

# make sure CMake finds the nuget installed package
find_package(OpenBLAS REQUIRED)

# OpenBLAS libraries are automatically mapped to the good arch/linkage
# combination
target_link_libraries(test_openblas ${OpenBLAS_LIBRARIES})
target_include_directories(test_glog PRIVATE ${OpenBLAS_INCLUDE_DIRS})

# copy the OpenBLAS-related DLLs to the output folder if desired.
openblas_copy_shared_libs(test_openblas)
```

Special thanks to https://github.com/willyd for the gflags example.
