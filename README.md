# tfwork
TerraForm practice with nginx web-server
# 개요 
- 기능 : TerraForm을 활용한 NginX 정적웹서버
- 키워드 : IaC(Infrastructure as Code), TerraForm, Docker, NginX
- 목적 : 테라폼을 활용한 IaC개념이해 및 실무적용

# 설치순서  
1) 서버생성 (ex:AWS Linux Ubuntu 22.04 / t4.nano / ARM64)
- ssh키다운로드
- 보안그룹설정 (port : 80, 8000, 8080 오픈)
2) 서버접속 (Ubuntu) : ssh클라이언트 혹은 콘솔접속 
3) docker설치 
$ curl -fsSL https://get.docker.com -o get-docker.sh 
$ sudo sh get-docker.sh
$ sudo docker run hello-world
3) 소스 Pull 
$ git pull https://github.com/GaussJung/tfwork.git  
$ cd ~/tfwork/nginx-terraform
4) 서비스기동
$ sudo terraform init  : 테라폼 초기화
$ sudo terraform plan  : (yes) / 계획설정
$ sudo terraform apply : (yes) / 적용 

# 기동테스트   
1) 웹브라우저 : http://서버IP:8080
2) curl 확인  
$ curl http://서버IP:8080
2) 로그확인 
$ tail -f ~/tfwork/nginx-resource/logs
3) 설정변경
$ vi ~/tfwork/nginx-resource/conf/myapp.conf 

# 자원삭제   
$ sudo terraform destroy : (yes) / 삭제  

- 끝 - 
