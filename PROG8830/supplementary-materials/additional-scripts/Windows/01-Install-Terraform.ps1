# ----------------------
# Terraform Installer
# ----------------------

# Specify the desired Terraform version:
$terraformVersion = "1.10.5"

# Construct the Terraform download URL
$downloadUrl = "https://releases.hashicorp.com/terraform/$($terraformVersion)/terraform_${terraformVersion}_windows_amd64.zip"

# Specify a temporary download path
$downloadPath = "$env:TEMP\terraform_${terraformVersion}_windows_amd64.zip"

Write-Host "Downloading Terraform $terraformVersion from $downloadUrl..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath -UseBasicParsing

Write-Host "Download complete. Extracting to C:\Terraform..."
# Create the C:\Terraform folder if it doesn't exist
if (!(Test-Path -Path 'C:\Terraform')) {
    New-Item -ItemType Directory -Path 'C:\Terraform' | Out-Null
}

# Extract the downloaded zip to C:\Terraform
Expand-Archive -Path $downloadPath -DestinationPath 'C:\Terraform' -Force

Write-Host "Extraction complete. Setting PATH..."

# Retrieve the current PATH from the machine environment
$machinePath = [System.Environment]::GetEnvironmentVariable('Path', 'Machine')

# Check if C:\Terraform is already in PATH
if ($machinePath -notmatch 'C:\\Terraform') {
    # Add C:\Terraform to PATH
    $newPath = $machinePath + ";C:\Terraform"
    [System.Environment]::SetEnvironmentVariable('Path', $newPath, 'Machine')
    Write-Host "C:\Terraform has been appended to the PATH environment variable."
} else {
    Write-Host "C:\Terraform is already in PATH."
}

Write-Host "Cleaning up temporary files..."
Remove-Item $downloadPath -Force

Write-Host "Terraform installation complete. Open a new PowerShell or CMD window to use Terraform."
