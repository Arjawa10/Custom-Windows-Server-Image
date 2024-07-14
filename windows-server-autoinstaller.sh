#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server version:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows 11"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows Server 2016
        img_file="windows2016.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195174&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2016.iso"
        ;;
    2)
        # Windows Server 2019
        img_file="windows2019.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2019.iso"
        ;;
    3)
        # Windows Server 2022
        img_file="windows2022.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2022.iso"
        ;;
    4)
        # Windows 11
        img_file="windows11.img"
        iso_link="https://software.download.prss.microsoft.com/dbazure/Win11_23H2_English_x64v2.iso?t=4b6f6bc9-8966-44d8-bc76-72952ef608e0&P1=1720967551&P2=601&P3=2&P4=S4KdQejQjBnoKTdUFhYXJdH04G9wdJcydUDa9WJGQDjivKnLlW9DZ5k1Zl2NlUnaZNhgACyv%2fvtYoABo0EMdrwq%2fDntPF4A6T6U19eDXWsApaSacgIVYcFn34RHk9kt62MdmelnFpA3g1mgmvz1grxPY1XMXNHfJcnyP7SnxXU5nfDRv9r1IDs3sHR6BUlho5%2b85AJIl%2bNU29McELTrXO0Zio41A%2bRDM4%2bjB1gdqr5tMq2HrQ8BW8oQfjCQTZyCpq9Vp0R1UuaRFfYThiFR1y170ub11mTo2uTbhlnEg3xACEm90RAejnvR1JKvIGhaB8BN0dIuhKcRMKyhBMtk4ww%3d%3d"
        iso_file="windows11.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected Windows Server version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 30G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
