# Description     
- 제목 : TFWork v0.71
- 작성 : C.W.Jung (cwjung123@gmail.com)
- 일자 : 2024. 03. 07 
- 기능 : TerraForm을 활용한 NginX 정적웹서버  
- 키워드 : IaC(Infrastructure as Code), TerraForm, Docker, NginX  
- 목적 : 테라폼을 활용한 IaC개념이해 및 실무적용  
- 사전지식 : Linux기본명령어, Cloud환경 가상서버 구동
- 소요시간 : 실습 30분 / 내용이해 30~60분  
  
# Create an instance and connect to it : 5-10 minutes     
1) 서버생성 (ex:AWS Linux Ubuntu 22.04 / t4.nano / ARM64)   
- ssh키다운로드
- 보안그룹설정 (port : 80, 8000, 8080 오픈)
  
2) 서버접속 (Ubuntu) : ssh클라이언트 혹은 콘솔접속

# Create resource and installation : 10-15 minutes    
1) Docker설치 : 1-3 minutes  
$ curl -fsSL https://get.docker.com -o get-docker.sh  
$ sudo sh get-docker.sh   : 1~2minutes   
$ sudo docker run hello-world  
(message) Hello from Docker!    
$ rm get-docker.sh     

2) 소스 Pull : 1-2 minutes   
$ git clone https://github.com/GaussJung/tfwork.git    
$ ls -al ~/tfwork  : 디렉토리생성확인   

3) TerraForm설치 (Ubuntu Linux) : 2-5 minutes  (아래 A 혹은 B 중의 한가지)   
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

4) TerraForm적용 : 2-5 minutes 
$ cd ~/tfwork/nginx-tf : 설정파일(main.tf) 및 변수파일(variables.tf)  
$ terraform init  : 초기화 (완료후 .terraform 디렉토리, .terraform.lock.hcl 파일 생성)  
(message)  
Terraform has been successfully initialized!  
$ sudo terraform plan  : (yes) / 계획설정  
(message)  
Plan: 2 to add, 0 to change, 0 to destroy.    
$ sudo terraform apply : (yes) / Create 적용  
(message)       
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.  

# Test : 1-5 minutes 
1) 도커기동 확인   
$ sudo docker ps -a
(example)
7cd7346bb61e   760b7cbba31e   "/docker-entrypoint.…"   31 seconds ago   Up 30 seconds       0.0.0.0:8090->80/tcp   MyNginxContainer   
 
2) 웹브라우저 접속확인  
주소줄 : http://15.15.000.000.35:8080   
※ 15.000.000.35는 서버의 Public IP에 해당.      
(screen)  
Hello Terraform Docker NginX WEB-Service V1.0  
  
3) curl 확인      
$ curl http://localhost:8080  
(message)    
Hello Terraform Docker NginX WEB-Service V1.0   

# Operation   
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

# Update Resource : 5-10 minutes
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
- 웹브라우저 : http://15.000.000.35:8000 접속  
- 혹은 명령어 $ curl http://localhost:8000  
(screen/message)  
Hello Terraform Docker NginX WEB-Service V1.1 Port 8000   

# Clean Resource : 1~2 minutes    	
$ cd ~/tfwork/nginx-tf   
$ sudo terraform destroy : (yes) / 삭제     
(message)  
Destroy complete! Resources: 2 destroyed. 
 
