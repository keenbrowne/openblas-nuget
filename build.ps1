
$currentWorkingDir = (Get-Location).Path

$openblases = @(
    (New-Object 'Tuple[string,string]'(
        "OpenBLAS-v0.2.14-Win64-int32",
        "1AA48CD356E8A66679005CF6CAFAF13DABF16A96C99291C732F273F15927A32D"
    )),
    (New-Object 'Tuple[string,string]'(
        "OpenBLAS-v0.2.14-Win64-int64",
        "DBA960D1CD9852CCF93AEE4A8F8F719AF49BAD7336B9BDFD19C38D398E9DFAF5"
    )),
    (New-Object 'Tuple[string,string]'(
        "OpenBLAS-v0.2.14-Win32",
        "64B5F11E4ADC57B55E8A800A798299B325E5F98DCA37B3B127FA6242D70A8917"
    ))
    (New-Object 'Tuple[string,string]'(
        "mingw64_dll",
        "A75B3BDD35D48DD9E7DE6BAD0442E9AEDC8B73420390F9949A2AC7DD20071B71"
    )),
    (New-Object 'Tuple[string,string]'(
        "mingw32_dll",
        "1D67B5EB4D94B8D9D0FD5D5E2E7D2F3FB2208E6FD51A8C1B31E6997C8BA70EE7"
    ))
)

foreach($openblas in $openblases) {
    $zip = Join-Path $env:Temp ("{0}.zip" -f $openblas.Item1)

    # If the file hasn't been downloaded or the hash doesn't match
    if (-not ((Test-Path $zip) -and `
             ((Get-FileHash -Path $zip).Hash -eq $openblas.Item2))) {
        # Download the file
        $url = "http://downloads.sourceforge.net/project/openblas/v0.2.14/{0}.zip?use_mirror=autoselect" -f $openblas.Item1
        $client = New-Object "System.Net.WebClient"
        $client.DownloadFile($url, $zip)
    }

    Expand-Archive -Path $zip -OutputPath $currentWorkingDir
}

Write-NuGetPackage .\openblas.autopkg
