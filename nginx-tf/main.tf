terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  
  // Refer image_id 
  image = docker_image.nginx.image_id
  
  // Refer : variables.tf
  name  = var.container_name

  // Auto start after reboot 
  restart = "unless-stopped"
  
  // Web document directory binding : upload ./wwwdoc/index.html  
  volumes {
    host_path      = "/home/ubuntu/tfwork/nginx-resource/wwwdoc"
    container_path = "/usr/share/nginx/html"
  }

  // Log file directory binding : tail -f ./logs/access.log & ./logs/error.log after startup 
  volumes {
    host_path      = "/home/ubuntu/tfwork/nginx-resource/logs"
    container_path = "/var/log/nginx"
  }

  // NginX base conf file binding  
  volumes {
    host_path      = "/home/ubuntu/tfwork/nginx-resource/conf/nginx.conf"
    container_path = "/etc/nginx/nginx.conf"
  }

  // NginX app conf file binding 
  volumes {
    host_path      = "/home/ubuntu/tfwork/nginx-resource/conf/myapp.conf"
    container_path = "/etc/nginx/conf.d/myapp.conf"
  }

  // Docker port setup 
  ports {
    internal = 80
    external = 8080
  }
}

