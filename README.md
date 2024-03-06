# Description     
- 제목 : TFWork v0.58
- 기능 : TerraForm을 활용한 NginX 정적웹서버  
- 키워드 : IaC(Infrastructure as Code), TerraForm, Docker, NginX  
- 목적 : 테라폼을 활용한 IaC개념이해 및 실무적용  
- 사전지식 : Linux기본명령어, Cloud환경 가상서버 구동  
  
# Create an instance and connect to it   
1) 서버생성 (ex:AWS Linux Ubuntu 22.04 / t4.nano / ARM64)   
- ssh키다운로드
- 보안그룹설정 (port : 80, 8000, 8080 오픈)
  
2) 서버접속 (Ubuntu) : ssh클라이언트 혹은 콘솔접속

# Create resource and installation   
1) docker설치   
$ curl -fsSL https://get.docker.com -o get-docker.sh   
$ sudo sh get-docker.sh   
$ sudo docker run hello-world

2) TerraForm설치   
(Ref) https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli    
$ sudo apt-get update && sudo apt-get install -y gnupg software-properties-common  
-- 생략 : 설치URL Ubuntu/Debian --
$ sudo apt update  
$ sudo apt-get install terraform  

3) 소스 Pull   
$ git clone https://github.com/GaussJung/tfwork.git    
$ cd ~/tfwork/nginx-tf

4) TerraForm적용 
$ terraform init  : 초기화   
$ sudo terraform plan  : (yes) / 계획설정
(message) Plan: 2 to add, 0 to change, 0 to destroy. 
$ sudo terraform apply : (yes) / 적용   	  
(message)  
docker_image.nginx: Creating...  
docker_image.nginx: Creation complete after 7s [id=sha256:760b7cbba31e196288effd2a--------------12984676nginx]  
docker_container.nginx: Creating...  
docker_container.nginx: Creation complete after 2s [id=d06680e20739069bcba253-------------53ed8ea3f2eda6]  

# Test   
1) 웹브라우저 : http://서버IP:8080  
(Screen)  
Hello Terraform Docker NginX WEB-Service V1.0  
  
2) curl 확인      
$ curl http://서버IP:8080    

# Operation    
1) 로그확인   	  
$ tail -f ~/tfwork/nginx-resource/logs     
2) 설정변경     
$ vi ~/tfwork/nginx-resource/conf/myapp.conf     
3) 웹문서변경     
$ vi ~/tfwork/nginx-resource/wwwdoc/index.html     
  
# Clean Resource   		
$ sudo terraform destroy : (yes) / 삭제    
