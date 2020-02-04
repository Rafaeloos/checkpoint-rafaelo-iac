# CREACION DE LOS ENTORNOS
resource "heroku_app" "testing" {
  name   = "devc-app-testing"
  region = "eu"
}

resource "heroku_app" "production" {
  name   = "devc-app-production"
  region = "eu"
  
}

resource "heroku_app" "developement" {
  name   = "devc-app-developement"
  region = "eu"
}

# CREACION DEL COMPLEMENTE DE LA BASE DE DATOS
resource "heroku_addon" "testing" {
  app  = "devc-app-testing"
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "developement" {
  app  = "devc-app-developement"
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "production" {
  app  = "devc-app-production"
  plan = "heroku-postgresql:hobby-dev"
}

# CREACION DEL COMPLEMENTE WEB TESTING

resource "heroku_build" "testing" {
  app = "devc-app-testing"

  source = {
    path = "./env-web/webtesting"
  }
}

resource "heroku_formation" "testing" {
  app        = "devc-app-testing"
  type       = "web"
  quantity   = 1
  size       = "Free"
  depends_on = [heroku_build.testing]
}

# CREACION DEL COMPLEMENTE WEB DESAROLLO

resource "heroku_build" "developement" {
  app = "devc-app-developement"

  source = {
    path = "./env-web/webdevelopement"
  }
}

resource "heroku_formation" "developement" {
  app        = "devc-app-developement"
  type       = "web"
  quantity   = 1
  size       = "Free"
  depends_on = [heroku_build.developement]
}

# CREACION DEL COMPLEMENTE WEB PRODUCION

resource "heroku_build" "production" {
  app = "devc-app-production"

  source = {
    path = "./env-web/webproduction"
  }
}

resource "heroku_formation" "production" {
  app        = "devc-app-production"
  type       = "web"
  quantity   = 1
  size       = "Free"
  depends_on = [heroku_build.production]
}

