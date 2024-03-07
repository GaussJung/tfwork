# Description     
- 제목 : TFWork v0.6
- 기능 : TerraForm을 활용한 NginX 정적웹서버  
- 키워드 : IaC(Infrastructure as Code), TerraForm, Docker, NginX  
- 목적 : 테라폼을 활용한 IaC개념이해 및 실무적용  
- 사전지식 : Linux기본명령어, Cloud환경 가상서버 구동
- 소요시간 : 실습 30분 / 내용이해 30~60분  
  
# Create an instance and connect to it : 5 ~ 10분   
1) 서버생성 (ex:AWS Linux Ubuntu 22.04 / t4.nano / ARM64)   
- ssh키다운로드
- 보안그룹설정 (port : 80, 8000, 8080 오픈)
  
2) 서버접속 (Ubuntu) : ssh클라이언트 혹은 콘솔접속

# Create resource and installation : 10 ~ 15분   
1) Docker설치 : 3분 
$ curl -fsSL https://get.docker.com -o get-docker.sh  
$ sudo sh get-docker.sh   : 1~2minutes   
$ sudo docker run hello-world  
(message) Hello from Docker!    
$ rm get-docker.sh     

2) 소스 Pull : 1분   
$ git clone https://github.com/GaussJung/tfwork.git    
$ ls -al ~/tfwork  : 디렉토리생성확인   

3) TerraForm설치 (Ubuntu Linux) : 5분 (아래 A 혹은 B 중의 한가지) 
- A. 기본설치 : 아래 설치안내URL접속후 Linux/Debian Tab내용 설치진행 
(Ref) https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli    
$ sudo apt-get update && sudo apt-get install -y gnupg software-properties-common  
(중간생략) 
$ sudo apt-get install terraform
- B. 빠른설치 : 배치스크립트 실행 
$ cd ~/tfwork/nginx-tf/scripts
$ bash ./terraform-ubuntu-install.sh
(message)
======= End of Ubuntu TerraForm Installation =======
- 설치확인 
$ terraform -version
(message)
Terraform v1.7.4 on linux_arm64

5) TerraForm적용 : 5분 
$ cd ~/tfwork/nginx-tf 
$ terraform init  : 초기화   
$ sudo terraform plan  : (yes) / 계획설정
(message) Plan: 2 to add, 0 to change, 0 to destroy. 
$ sudo terraform apply : (yes) / Create 적용   	  
(message)  
docker_image.nginx: Creating...  
docker_image.nginx: Creation complete after 7s [id=sha256:760b7cbba31e196288effd2a--------------12984676nginx]  
docker_container.nginx: Creating...  
docker_container.nginx: Creation complete after 2s [id=d06680e20739069bcba253-------------53ed8ea3f2eda6]  

# Test : 1분    
1) 웹브라우저 : http://15.000.000.35:8080
※ 15.000.000.35는 서버의 Public IP에 해당. -  
(Screen)  
Hello Terraform Docker NginX WEB-Service V1.0  
  
2) curl 확인      
$ curl http://localhost:8000
(message)
Hello Terraform Docker NginX WEB-Service V1.0 

# Operation : 5분     
1) 로그파일    
- 접속로그 : ~/tfwork/nginx-resource/logs/access.log  
- 오류로그 : ~/tfwork/nginx-resource/logs/error.log     
※ 모니터링 : tail -f 로그파일경로   
      
2) 설정파일   
- 기본설정 : ~/tfwork/nginx-resource/conf/nginx.conf     
- 추가설정 : ~/tfwork/nginx-resource/conf/myapp.conf       
※ 설정변경 : vi 설정파일경로  
 
3) 웹문서변경    
- Base디렉토리 :  ~/tfwork/nginx-resource/wwwdoc    
- 기본문서내용변경 : index.html 편집    

# Update Resource : 5~10분  
웹문서 내용을 변경후에 8080포트가 아닌 8000포트로 변경 

1) 웹문서 변경
$ vi ~/tfwork/nginx-resource/wwwdoc/index.html
(old)
Hello Terraform Docker NginX WEB-Service V1.0
(new)
Hello Terraform Docker NginX WEB-Service V1.1 Port 8000
※ vi편집 : i / vi보기 : ESC / vi내용저장 : wq! / vi라인삭제 : dd

2) 접속포트 변경  
$ cd ~/tfwork/nginx-tf   
$ vi main.tf : 설정파일 하단의 내용변경      
(old) external = 8080  
(new) external = 8000  
  
3) 테라폼 실행  
sudo terraform apply : (yes) / Update 적용   	  
(message)
Apply complete! Resources: 1 added, 0 changed, 1 destroyed

4) 접속확인 (8080이 아닌 8000번 포트 유의) 
http://15.000.000.35:8000/   
(Screen)  
Hello Terraform Docker NginX WEB-Service V1.1 Port 8000  

# Clean Resource : 1분    		
$ sudo terraform destroy : (yes) / 삭제    
