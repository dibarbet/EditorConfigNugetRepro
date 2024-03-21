Write-Host ""
Write-Host "---- Running *WITHOUT* trailing slash ----" -ForegroundColor Green
$env:NUGET_PACKAGES=(Join-Path $PSScriptRoot "packages")
Write-Host "Using NUGET_PACKAGES directory: $env:NUGET_PACKAGES" -ForegroundColor Green

git clean -xdf
Write-Host "Creating nuget package with editorconfig..." -ForegroundColor Green
dotnet build ./NugetPackageWithEditorConfig/ --no-incremental
dotnet pack ./NugetPackageWithEditorConfig/ --configuration Debug
Write-Host "Rebuilding consuming package..." -ForegroundColor Green
dotnet build ./ConsumeNuget/ --no-incremental

Write-Host ""
Write-Host ""

Write-Host "---- Running *WITH* trailing slash ----" -ForegroundColor Green
$env:NUGET_PACKAGES=(Join-Path $PSScriptRoot "packages/")
Write-Host "Using NUGET_PACKAGES directory: $env:NUGET_PACKAGES" -ForegroundColor Green

git clean -xdf
Write-Host "Creating nuget package with editorconfig..." -ForegroundColor Green
dotnet build ./NugetPackageWithEditorConfig/ --no-incremental
dotnet pack ./NugetPackageWithEditorConfig/ --configuration Debug
Write-Host "Rebuilding consuming package..." -ForegroundColor Green
dotnet build ./ConsumeNuget/ --no-incremental

