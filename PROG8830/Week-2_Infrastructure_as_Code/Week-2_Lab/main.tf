terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# Configure the Docker provider
provider "docker" {
  # host = "unix:///var/run/docker.sock"
  # host = "npipe:////./pipe/docker_engine"   #  Windows
}

resource "null_resource" "build_image" {
  provisioner "local-exec" {
    command = "docker build -t demo-web-app-image ${path.module}/app"
  }
}

# Create and run a container from the image
resource "docker_container" "node_web_app_container" {
  name  = "demo-web-app-container"
  image = "demo-web-app-image"

  ports {
    internal = 3000
    external = 3000
  }
}
