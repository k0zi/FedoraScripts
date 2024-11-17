#!/bin/bash

# Function to check if the user has root privileges
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run this script as root or use sudo."
        exit 1
    fi
}

# Function to uninstall Mono and .NET
uninstall_packages() {
    echo "Uninstalling Mono and .NET..."
    dnf remove -y mono-* dotnet-* || {
        echo "Failed to uninstall Mono and .NET. Aborting."
        exit 1
    }
}

# Function to reinstall Mono
reinstall_mono() {
    echo "Reinstalling Mono..."
    dnf install -y mono-devel mono-complete mono-extras || {
        echo "Failed to install Mono. Aborting."
        exit 1
    }
}

# Function to reinstall .NET SDK and runtime
reinstall_dotnet() {
    echo "Reinstalling .NET SDK and Runtime..."
    dnf install -y dotnet-sdk-8.0 dotnet-runtime-8.0 dotnet-sdk-9.0 dotnet-runtime-9.0 || {
        echo "Failed to install .NET. Aborting."
        exit 1
    }
}

# Function to find subdirectories named workloadsets
find_workloadsets_subdirs() {
    echo "Finding subdirectories named 'workloadsets' in /usr/share/dotnet/sdk-manifests/..."
    find /usr/share/dotnet/sdk-manifests/ -type d -name "workloadsets"
}

# Function to find and remove empty subdirectories within workloadsets
cleanup_empty_subdirs_within_workloadsets() {
    local workloadsets_dirs
    workloadsets_dirs=$(find_workloadsets_subdirs)
    
    echo "Cleaning up empty subdirectories within workloadsets directories..."
    
    while IFS= read -r dir; do
        echo "Checking directory: $dir"
        find "$dir" -type d -empty | while IFS= read -r empty_dir; do
            rmdir "$empty_dir"
            echo "Removed empty directory: $empty_dir"
        done
    done <<< "$workloadsets_dirs"
}

# Main script execution
main() {
    check_root
    uninstall_packages
    cleanup_empty_subdirs_within_workloadsets
    reinstall_mono
    reinstall_dotnet
    ln -s /usr/share/dotnet/sdk/ /usr/lib64/dotnet/sdk
    echo "Mono and .NET reinstallation completed successfully."
}

main
