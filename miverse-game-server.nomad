job "miverse-game-server" {
  datacenters = ["dc1"]

  group "game-server" {
    count = 1

    network {
      port "webapp_http" {}
    }

    

    task "server" {
      driver = "docker"

      config {
        image = "docker.yahaha.com/yahaha/miverse-game-server@sha256:80e6585c462a6231718f04e48875e8f63ef9c995413223d353f55a9e06918247"
        ports = ["webapp_http"]
        auth {
          username = "yahaha"
          password = "q1w2E#R$"
        }
      }


   artifact {
        source      = "https://raw.githubusercontent.com/symsimmy/configs/main/dev.json"
        destination = "/app/Configs/dev.json"
      }

      env {
        PORT    = "${NOMAD_PORT_webapp_http}"
        NODE_IP = "${NOMAD_IP_webapp_http}"
        SERVER_MODE = "true"
        ENV = "dev"
      }

      resources {
        cpu    = 1024
        memory = 512
      }

       service {
        name = "game-server"
        provider = "nomad"
        port = "webapp_http"
      }
    }


  }
}
