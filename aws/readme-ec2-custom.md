# Description     
- 제목 : EC2인스턴스 맞춤 생성 
- 작성 : 정철웅 (cwjung123@gmail.com)
- 버전 : 0.585  
- 기능 : TerraForm을 활용한 EC2인스턴스 맞춤생성 
- 키워드 : IaC(Infrastructure as Code), TerraForm, EC2 
- 소요시간 : 실습 40분 

# 설치서버생성 (AWS콘솔) 
1) 서버생성 (ex:AWS Linux Ubuntu 22.04 / t2.micro / x86_64)   
- 이름 : TEST-TF-EC2
- ssh키다운로드
- 보안그룹설정 (port : 22, 80, 8000, 8080, etc)
  
2) 서버접속 (Ubuntu) : ssh클라이언트 혹은 콘솔접속

# 실습소스 Pull  (위에서 생성한 EC2접속)
$ git clone https://github.com/GaussJung/tfwork.git    
  
# 사전준비사항(Prerequsite)  
1) Terraform CLI설치 (Ubuntu Linux)  
(Ref) https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli      
위의 URL을 참조하여 설치하거나 아래의 스크립트 실행   
$ cd ~/tfwork/scripts  
$ bash ./terraform-ubuntu-install.sh   
(message)   
======= End of Ubuntu TerraForm Installation =======   
$ terraform -version : 설치확인 
(message)   
Terraform v1.X.X on linux_arm64   

2) AWS CLI설치  
(Ref) https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/getting-started-install.html  
위의 URL을 참조하여 설치하거나 아래의 스크립트 실행     
$ cd ~/tfwork/scripts    
$ bash ./awscli-ubuntu-install.sh  
(message)    
======= End of Ubuntu AWS CLI Version2 Installation =======  
  
3) AWS CLI구성  
A. AWS콘솔에서 IAM사용자 생성후 csv파일 다운로드  
B. CLI구성 : 환경변수 내보내기 (1회 사용 / aws configure를 진행하지 않을 경우)  
 $ export AWS_ACCESS_KEY_ID=AKIAS----------ZPJEC  
 $ export AWS_SECRET_ACCESS_KEY=t4yv8tC--------------------th0TKOeDcl    
C. CLI구성 : 설정파일 저장방식 (편리 but 보안측면 유의!) 
$ aws configure  : AWS CLI 다양한 기능활용 (아래의 환경변수 내보내기 하지 않아도 됨)  
```
$ aws configure
AWS Access Key ID [None]: AKIAS----------ZPJEC
AWS Secret Access Key [None]: t4yv8tC--------------------th0TKOeDcl
Default region name [None]: ap-northeast-2
Default output format [None]: json

$ aws --ver  
(message)  
aws-cli/2.15.XX Python/3.XX.XX Linux/6.5.0-XXXX-aws exe/x86_64.ubuntu.22 prompt/off
```   

# TerraForm적용   
$ cd ~/tfwork/aws/ec2-custom : 설정파일(main.tf) 내용확인     
```
// 버전에 유의해야함 : 5.0 (terraform validate에서 오류날 경우 확인)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

// ami-0a55ba1c20b74fc30 : Ubuntu 22.04 for Arm64 
// 사전에 생성된 키 및 보안그룹을 사용하여 인스턴스 생성 (콘솔에서)
resource "aws_instance" "my_server" {

  ami = "ami-0a55ba1c20b74fc30"

  instance_type = "t4g.nano"

  key_name = "myawskeyname"

  vpc_security_group_ids = ["sg-025f67----7509eed1"]

  tags = {
    Name = "TF-AppCustomInstance"
  }

}
```

$ terraform init  : 초기화 (완료후 .terraform 디렉토리, .terraform.lock.hcl 파일 생성)  
(message)  
Terraform has been successfully initialized!   

$ terraform validate : 문법 검토  
이상이 없을 경우 아래의 plan단계로 넘어감.  이상 있는 경우 plan에서 제대로 동작하지 않음  
(message)  
Success! The configuration is valid.  

$ terraform plan  : (yes) / 계획설정  
(message)  
```
ubuntu@ip-172-34-1-101:~/tfwork/aws/ec2-custom$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

  # aws_instance.my_server will be created
  + resource "aws_instance" "my_server" {
      + ami                                  = "ami-0a55b----0b74fc30"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t4g.nano"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "myawskeyname"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "TF-AppCustomInstance"
        }
      + tags_all                             = {
          + "Name" = "TF-AppCustomInstance"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = [
          + "sg-025f677----509eed1",
        ]
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

$ sudo terraform apply : (yes) / Create 적용  
(message)       
```
ubuntu@ip-172-34-1-101:~/tfwork/aws/ec2-custom$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.app_server will be created
  + resource "aws_instance" "my_server" {
      + ami                                  = "ami-0a55b----0b74fc30"
      + key_name                             = "myawskeyname"
       -------- 생략 ---------
      + vpc_security_group_ids               = [
          + "sg-025f67----509eed1",
        ]
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.app_server: Creating...
aws_instance.app_server: Still creating... [10s elapsed]
aws_instance.app_server: Creation complete after 18s [id=i-0b155----6519ddb]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
 
# TerraForm생성 리소스 확인 : 콘솔접속후 확인  
- EC2생성확인    
<kbd>![생성완료EC2](https://github.com/GaussJung/tfwork/assets/76603627/480a2594-f000-4485-954c-6bfba05baa05)</kbd>  
- AWS계정접속하여 EC2로 이동
- 생성된 EC2에 접속함. 

# TerraForm 리소스 삭제  
$ cd ~/tfwork/aws/ec2-custom  
$ sudo terraform destroy : (yes) / 삭제     
(message)  
```
ubuntu@ip-172-34-1-101:~/tfwork/aws/ec2-custom$ terraform destroy
aws_instance.app_server: Refreshing state... [id=i-0b155----6519ddb]
 
Terraform will perform the following actions:

  # aws_instance.app_server will be destroyed
  - resource "aws_instance" "my_server" {
      - ami                                  = "ami-0a55b----0b74fc30" -> null
      - arn                                  = "arn:aws:ec2:us-east-1:111152282222:instance/i-0b1551df3f6519ddb" -> nulli-7b70a-----yu5c77" -> null
      - associate_public_ip_address          = true -> null
      - availability_zone                    = "us-east-1b" -> null
      --- 생략 ---
  } 
  
Plan: 0 to add, 0 to change, 1 to destroy.

Enter a value: yes

aws_instance.my_server: Destroying... [id=i-0b155----6519ddb]
aws_instance.my_server: Still destroying... [id=i-0b155----6519ddb, 10s elapsed]
-- 생략 --
aws_instance.my_server: Still destroying... [id=i-0b155----6519ddb, 1m10s elapsed]
aws_instance.my_server: Destruction complete after 42s
``` 

