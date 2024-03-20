#! /bin/bash

# 기능 : TerraForm CLI설치 
# 설치 Ref URL : https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli   
# 대상 OS : Ubuntu Linux
# 작성자 : 정철웅 (cwjung123@gmail.com)
# version : 1.0 

# Step1. Install gnupg, software-properties-common, and curl 
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common 
sleep 1 

# Step2. Install the HashiCorp GPG key.
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
sleep 1 

#3. Step3. Verify the key's fingerprint.
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
sleep 1 

#4. Add the official HashiCorp repository to your system.
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sleep 1 

#5. Download the package information from HashiCorp.
sudo apt update -y 
sleep 1 

#6. Install Terraform from the new repository 
sudo apt-get install terraform
sleep 1 

#7. Final Success Message 
echo "======= End of Ubuntu TerraForm Installation ======="

