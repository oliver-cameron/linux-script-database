#!/bin/bash
## Step 2: Update, Install ClamTk, and Enable Firewall
apt-get update
apt-get upgrade -y
apt-get install clamtk -y
apt-get upgrade clamtk
clamscan -r /
ufw enable

# Step 4: Remove audio and/or video and/or other file types
# Prompt the user to select the files to remove
echo "Which files do you want to remove?"
echo "1. Audio files"
echo "2. Video files"
echo "3. Both audio and video files"
echo "4. Other files (Specify file extensions)"

read -p "Enter the corresponding number: " choice

# Define variables for file extensions
audio_extensions=".mp3 .wav .aac .flac .ogg"
video_extensions=".mp4 .avi .mkv .wmv .mov"
other_extensions=""

# Process user's choice
case $choice in
    1)
        extensions="$audio_extensions"
        ;;
    2)
        extensions="$video_extensions"
        ;;
    3)
        extensions="$audio_extensions $video_extensions"
        ;;
    4)
        read -p "Enter the file extensions to remove (space-separated): " other_extensions
        extensions="$other_extensions"
        ;;
    *)
        echo "Invalid choice. Exiting..."
        exit 1
        ;;
esac

# Confirm file removal
read -p "Are you sure you want to remove files with the following nstall Required Packages
# Install required packages using apt-get or any package manager
# sudo apt-get instalextensions: $extensions? (y/n) " confirm

if [[ $confirm == "y" ]]; then
    # Remove files based on selected extensions
    find / -type f \( -name "*$extensions" \) -delete
    echo "Files with extensions $extensions have been removed."
else
    echo "File removal operation cancelled."
fi

# Step 6: Il package1 package2 package3

# Step 7: Set Automatic Updates
# Enable automatic updates for security updates
sed -i 's/APT::Periodic::Update-Package-Lists "0";/APT::Periodic::Update-Package-Lists "1";/g' /etc/apt/apt.conf.d/20auto-upgrades
sed -i 's/APT::Periodic::Unattended-Upgrade "0";/APT::Periodic::Unattended-Upgrade "1";/g' /etc/apt/apt.conf.d/20auto-upgrades

# Step 8: Set Password Policy
# Generate a random password
generate_password() {
   	pw_length=12  # Change the length as per your requirements  
pw_characters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-=_+"
  	 password=$(tr -dc "$pw_characters" < /dev/urandom | fold -w "$pw_length" | head -n 1)
  	 echo "$password"
}

# Generate and apply new password to root and 'ubuntu' user
new_password=$(generate_password)

echo "Generated Password: $new_password"

# Change root password
echo "Changing root password..."
echo "root:$new_password" | sudo chpasswd

# Change 'ubuntu' user password
echo "Changing 'ubuntu' user password..."
echo "ubuntu:$new_password" | sudo chpasswd

# Display new passwords
echo "New root password: $new_password"
echo "New 'ubuntu' user password: $new_password"

# Change the password policy in /etc/login.defs
sed -i 's/PASS_MAX_DAYS\t99999/PASS_MAX_DAYS\t30/' /etc/login.defs
sed -i 's/PASS_MIN_DAYS\t0/PASS_MIN_DAYS\t7/' /etc/login.defs
sed -i 's/PASS_WARN_AGE\t7/PASS_WARN_AGE\t14/' /etc/login.defs


echo "Password policy has been updated."
#change
