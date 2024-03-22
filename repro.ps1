function runBuilds($NUGET_PACKAGES, $nugetPackageRoot, $binlogName) {
    Remove-Item -Recurse (Join-Path "$PSScriptRoot" "bin")
    Remove-Item -Recurse (Join-Path "$PSScriptRoot" "obj")

    $env:MSBUILDLOGALLENVIRONMENTVARIABLES=1
    $env:NUGET_PACKAGES="$NUGET_PACKAGES"
    $nugetPackageRoot = "$nugetPackageRoot"
    Write-Host "Using NUGET_PACKAGES: $env:NUGET_PACKAGES" -ForegroundColor Green
    Write-Host "Using /p:NuGetPackageRoot: $nugetPackageRoot" -ForegroundColor Green
    Write-Host "Creating nuget package with editorconfig..." -ForegroundColor Green
    dotnet build ./NugetPackageWithEditorConfig/ --no-incremental
    dotnet pack ./NugetPackageWithEditorConfig/ --configuration Debug
    Write-Host "Rebuilding consuming package..." -ForegroundColor Green
    dotnet build ./ConsumeNuget/ --no-incremental -bl:$binlogName /p:NuGetPackageRoot="$nugetPackageRoot"
}

Write-Host "---- Trailing slash in NUGET_PACKAGES != NugetPackageRoot ----" -ForegroundColor Green
runBuilds "$PSScriptRoot\.packages" "$PSScriptRoot\.packages\" "$PSScriptRoot\mismatch.binlog"

Write-Host ""
Write-Host ""
Write-Host "---- Trailing slash in NUGET_PACKAGES == NugetPackageRoot ----" -ForegroundColor Green
runBuilds "$PSScriptRoot\.packages\" "$PSScriptRoot\.packages\" "$PSScriptRoot\match.binlog"


