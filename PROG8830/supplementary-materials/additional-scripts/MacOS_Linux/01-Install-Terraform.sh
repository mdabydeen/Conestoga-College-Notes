#! /bin/bash

# ----------------------
# Terraform Installer
# ----------------------

# Check if the system is a Mac or Linux
if [ "$(uname -s)" == "Darwin" ]; then
    # This machine is a Mac
    OS="mac"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # This machine is a Linux
    OS="linux"
else
    echo "Unsupported operating system"
    exit 1
fi

# Specify the desired Terraform version:
terraform_version="1.10.5"

# Set the download URL
if [ "$OS" == "mac" ]; then
    # Construct the Terraform download URL for Mac
    download_url="https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_darwin_amd64.zip"
elif [ "$OS" == "linux" ];then
    # Construct the Terraform download URL for Linux
    download_url="https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip"
fi

# Download Terraform
echo "Downloading Terraform..."
curl -s -o terraform.zip "$download_url"

# Check if the download was successful
if [ $? -ne 0]; then
    echo "Failed to download Terraform"
    exit 1
fi

# Extract Terraform
echo "Extracting Terraform..."
unzip -q terraform.zip

# Move Terraform to /usr/local/bin
echo "Cleaning up..."
rm terraform.zip

# Verify the installation
echo "Verifying the installation..."
terraform --version

echo "Terraform installed successfully"
