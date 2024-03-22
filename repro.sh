echo ""
echo "---- Running *WITHOUT* trailing slash ----"
export NUGET_PACKAGES="$PWD//packages"
echo "Using NUGET_PACKAGES directory: $NUGET_PACKAGES"

git clean -xdf
echo "Creating nuget package with editorconfig..."
dotnet build ./NugetPackageWithEditorConfig/ --no-incremental
dotnet pack ./NugetPackageWithEditorConfig/ --configuration Debug
echo "Rebuilding consuming package..."
dotnet build ./ConsumeNuget/ --no-incremental

echo ""
echo ""

echo "---- Running *WITH* trailing slash ----"
export NUGET_PACKAGES="$PWD//packages/"
echo "Using NUGET_PACKAGES directory: $NUGET_PACKAGES"

git clean -xdf
echo "Creating nuget package with editorconfig..."
dotnet build ./NugetPackageWithEditorConfig/ --no-incremental
dotnet pack ./NugetPackageWithEditorConfig/ --configuration Debug
echo "Rebuilding consuming package..."
dotnet build ./ConsumeNuget/ --no-incremental

