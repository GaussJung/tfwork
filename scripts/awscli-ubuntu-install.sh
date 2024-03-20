#! /bin/bash

# 기능 : AWS-CLI설치 
# 설치 Ref URL : https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/getting-started-install.html
# 대상 OS : Ubuntu Linux
# 작성자 : 정철웅 (cwjung123@gmail.com)
# version : 1.01 

OSArch=$(uname -m)

# Step1. Install unzip
sudo apt install unzip
sleep 1 

# Step2. Install AWS CLI Version2 
if [ "$OSArch" = "aarch64" ]; then 
  echo "======= ARM Architecture  : $OSArch  ======" 
  curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
elif [ "$OSArch" = "x86_64" ]; then
  echo "======= X86 Architecture  : $OSArch  ======"
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
else
  echo "========= Unsupported Architecture : $OSArch ========"
  exit 0 
fi 
sleep 1 
unzip awscliv2.zip > /dev/null 
sudo ./aws/install > /dev/null
sleep 1 

#3. Step3. Remove file 
rm awscliv2.zip 
rm -rf aws 

#4. Step4. Check aws cli version 
aws --version


#4. Final Success Message 
echo "======= End of Ubuntu AWS CLI Version2 Installation ======="