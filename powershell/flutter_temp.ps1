# Requires -Version 5.1
param(
    [Parameter(Mandatory=$true)]
    [string]$NewProjectName
)

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Not running as Administrator. Please run PowerShell as Administrator."
    exit 1
}


# Validate project name (similar to Flutter's constraints)
$check = -not ($NewProjectName -cmatch '^[a-z_]+[a-z0-9_]*$')
echo $check
if (-not ($NewProjectName -cmatch '^[a-z_][a-z0-9_]*$')) {
    Write-Host "Project name '$NewProjectName' is not valid. It must start with a lowercase letter or underscore, followed by lowercase letters, digits, or underscores, and not include spaces or special characters."
    exit 1
}

$PackageName = "com.example.$NewProjectName"
$TemplateGitURL = "https://github.com/sublime-developer-5/flutter_template.git"

# Clone the template
git clone $TemplateGitURL $NewProjectName

# Change to the project directory
cd $NewProjectName

# Remove the existing .git directory to start fresh
Remove-Item .git -Force -Recurse

# Initialize a new git repository
git init

# Use flutter_rename_app to rename the app and bundle identifiers
flutter pub get
flutter pub global activate rename
dart run rename setAppName --targets ios,android --value "$NewProjectName"
dart run rename setBundleId --targets android --value "$PackageName"

# Update project name in pubspec.yaml
(Get-Content pubspec.yaml).Replace('name: my_template', "name: $NewProjectName") | Set-Content pubspec.yaml

# Ensure you're running from the project root
$ProjectRoot = Get-Location

# Define the full old and new paths
$OldPath = Join-Path -Path $ProjectRoot -ChildPath "android\app\src\main\kotlin\com\example\my_template"
$NewPath = Join-Path -Path $ProjectRoot -ChildPath "android\app\src\main\kotlin\com\example\$NewProjectName"

# Rename the directory
if (Test-Path $OldPath) {
    Move-Item -Path $OldPath -Destination $NewPath
}

# Update the package name in MainActivity.kt
$MainActivityPath = Join-Path -Path $NewPath -ChildPath "MainActivity.kt"
if (Test-Path $MainActivityPath) {
    (Get-Content $MainActivityPath) -replace 'package com.example.my_template', "package com.example.$NewProjectName" | Set-Content $MainActivityPath
}

# Update Dart file imports to reflect the new package name
$DartFiles = Get-ChildItem -Path $ProjectRoot -Filter *.dart -Recurse
foreach ($file in $DartFiles) {
    (Get-Content $file.FullName) -replace 'package:my_template', "package:$NewProjectName" | Set-Content $file.FullName
}

# Add changes to git and make initial commit
git add .
git commit -m "Initial commit based on my Flutter template with customized project settings"

Write-Host "Your new Flutter project '$NewProjectName' is ready and based on your custom template with updated configurations."

# open vs-code
code .