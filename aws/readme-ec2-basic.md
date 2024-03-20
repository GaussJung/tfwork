# Description     
- 제목 : EC2인스턴스 단순 생성 
- 작성 : 정철웅 (cwjung123@gmail.com)
- 버전 : 0.5
- 기능 : TerraForm을 활용한 EC2인스턴스 기본생성 
- 키워드 : IaC(Infrastructure as Code), TerraForm, EC2 
- 소요시간 : 실습 30분 

# 설치서버생성 (AWS콘솔) 
1) 서버생성 (ex:AWS Linux Ubuntu 22.04 / t2.micro / x86_64)   
- 이름 : TEST-TF-EC2
- ssh키다운로드
- 보안그룹설정 (port : 22, 80, 8000, 8080, etc)
  
2) 서버접속 (Ubuntu) : ssh클라이언트 혹은 콘솔접속

# 실습소스 Pull  (위에서 생성한 EC2접속)
$ git clone https://github.com/GaussJung/tfwork.git    
 
# 사전준비사항(Prerequsite)
1) Terraform CLI설치 (Ubuntu Linux) : 2-5 minutes  
(Ref) https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli      
$ cd ~/tfwork/nginx-tf/scripts  
$ bash ./terraform-ubuntu-install.sh  
(message)  
======= End of Ubuntu TerraForm Installation =======

2) AWS CLI설정  
(Ref) https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/getting-started-install.html  
$ cd ~/tfwork/nginx-tf/scripts    
$ tfwork/scripts/awscli-ubuntu-install.sh  
(message)    
======= End of Ubuntu AWS CLI Version2 Installation =======  
$ aws configure  (사전에 IAM사용자설정)  
  
3) CLI환경변수 내보내기   
$ export AWS_ACCESS_KEY_ID=
$ export AWS_SECRET_ACCESS_KEY= 
  
4) 테라폼 설치확인   
$ terraform -version   
(message)   
Terraform v1.7.4 on linux_arm64   


 
# TerraForm적용   

$ cd ~./tfwork/aws/ec2-basic : 설정파일(main.tf)   

$ terraform validate : 문법 검토 
- 이상이 없을 경우 아래의 init단계로 넘어감.  이상 있는 경우 plan에서 제대로 동작하지 않음  

$ terraform init  : 초기화 (완료후 .terraform 디렉토리, .terraform.lock.hcl 파일 생성)  
(message)  
Terraform has been successfully initialized!   

$ sudo terraform plan  : (yes) / 계획설정  
(message)  
Plan: 2 to add, 0 to change, 0 to destroy.   

$ sudo terraform apply : (yes) / Create 적용  
(message)       
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.  

# TerraForm생성 리소스 확인 : 콘솔접속후 확인 
- AWS계정접속하여 EC2로 이동
- 생성된 EC2에 접속함. 

# TerraForm Clean Resource : 1~5분     	
$ cd ~/tfwork/nginx-tf   
$ sudo terraform destroy : (yes) / 삭제     
(message)  
Destroy complete! Resources: 2 destroyed. 
 
