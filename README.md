# Description     
- 제목 : TFWork v0.751
- 작성 : C.W.Jung (cwjung123@gmail.com)
- 기능 : TerraForm을 활용한 인프라관리 
- 목적 : 테라폼을 활용한 IaC개념이해 및 실무적용  
- 사전지식 : Linux기본명령어, Cloud환경 가상서버 구동
 
# 실습분류      
1) NginX 테라폼 
./nginx-tf/readme-nginx.md 
 
2) AWS리소스 테라폼 
- ec2기본 :  [./aws/ec2-basic/readme.md](https://github.com/GaussJung/tfwork/blob/master/aws/readme-ec2-basic.md) 
- ec2맞춤 : [./aws/ec2-custom/readme.md](https://github.com/GaussJung/tfwork/blob/master/aws/readme-ec2-custom.md) 
- s3생성 :  Later

# 사전작업    
1) 소스 Pull  
$ git clone https://github.com/GaussJung/tfwork.git    
$ ls -al ~/tfwork  : 디렉토리생성확인   

2) TerraForm설치 (Ubuntu Linux) : 2-5 minutes  (아래 A 혹은 B 중의 한가지)   
- A. 기본설치 : 아래 설치안내URL접속후 Linux/Debian Tab내용 설치진행   
(Ref) https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli      
$ sudo apt-get update && sudo apt-get install -y gnupg software-properties-common  
(중간생략) 
$ sudo apt-get install terraform

- B. 빠른설치 : 배치스크립트 실행   
$ cd ~/tfwork/scripts  
$ bash ./terraform-ubuntu-install.sh  
(message)  
======= End of Ubuntu TerraForm Installation =======

- 설치확인   
$ terraform -version  
(message)  
Terraform v1.7.4 on linux_arm64  
 
# 참조링크   
- 테라폼홈 : https://developer.hashicorp.com/terraform   
- 테라폼시작 : https://developer.hashicorp.com/terraform/tutorials  
