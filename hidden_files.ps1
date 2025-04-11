# Attenzione: This script will search for hidden files in the specified directory and its subdirectories.
# It will prompt the user to delete each hidden file found. 
# Define the directory to search
# Change this to the directory you want to search
# Example: "C:\Users\thyke\Documenti"
$directory = "C:\Users\thyke\Documents\Nuova cartella"

# Check if the directory exists
if (-Not (Test-Path -Path $directory)) {
    Write-Host "The specified directory does not exist." -ForegroundColor Red
    exit
}

# Search for hidden files
Write-Host "Searching for hidden files in $directory and its subdirectories..." -ForegroundColor Green
$hiddenFiles = Get-ChildItem -Path $directory -Recurse -Force | Where-Object { $_.Attributes -match "Hidden" }

# Display the results and provide delete option
if ($hiddenFiles) {
    Write-Host "Hidden files found:" -ForegroundColor Yellow
    foreach ($file in $hiddenFiles) {
        Write-Host "File: $($file.FullName)" -ForegroundColor Cyan
        $response = Read-Host "Do you want to delete this file? (Y/N)"
        if ($response -eq "Y" -or $response -eq "y") {
            try {
                Remove-Item -Path $file.FullName -Force
                Write-Host "File deleted: $($file.FullName)" -ForegroundColor Green
            } catch {
                Write-Host "Failed to delete file: $($file.FullName)" -ForegroundColor Red
            }
        } else {
            Write-Host "File skipped: $($file.FullName)" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "No hidden files found." -ForegroundColor Cyan
}