package main

// Get-NetTCPConnection | Where-Object { $_.LocalPort -eq 3000 }
// Stop-Process -Id 17764

import (
	"context"
	"goland/api/v1/user"
	"goland/db"
	"goland/handler"
	"net/http"

	_ "github.com/go-sql-driver/mysql"
	"github.com/labstack/echo/v4"
)

func main() {

	//Mysql
	db, err := db.New("root@tcp(localhost:3306)/wizatek")
	if err != nil {
		panic(err)
	}

	h := &handler.Handler{DB: db}

	app := echo.New()

	//Home Testing
	indexHandler := handler.IndexHandler{DB: db}
	app.GET("/", indexHandler.HandlerIndex)

	// Register - Login - Reset
	pasaDatosAuth := handler.AuthHandler{DB: db}
	app.GET("/login", pasaDatosAuth.LoginF, user.RedirectIfAuthenticated)
	app.GET("/register", pasaDatosAuth.RegisterF, user.RedirectIfAuthenticated)
	app.GET("/reset", pasaDatosAuth.ResetF, user.RedirectIfAuthenticated)

	//Singles
	memeHandler := handler.MemesHandler{}
	app.GET("/meme/:id", memeHandler.SingleMeme)

	newsHandler := handler.NewsHandler{}
	app.GET("/news/:id", newsHandler.SingleNews)

	app.GET("/anime/:id", h.GetVersion)
	// Agregar la nueva ruta aquí
	app.GET("/versiones", h.GetAllVersions)
	// Registrarse, Iniciar Sesion y Resetear Contraseña

	app.POST("/api/v1/register", func(c echo.Context) error { return user.Register(db, c) }, user.RedirectIfAuthenticated)
	app.POST("/api/v1/login", func(c echo.Context) error { return user.Login(db, c) }, user.RedirectIfAuthenticated)
	app.POST("/api/v1/reset", func(c echo.Context) error { return user.Reset(db, c) }, user.RedirectIfAuthenticated)

	app.Start(":3000")

	// app.GET("/test", h.algunaFuncion)
}

// /proyecto
//   /api
//     /v1
//       /usuarios
//         usuarios.go
//       /versiones
//         versiones.go
//   /web
//     /public
//       /css
//       /js
//       /imagenes
//     /vistas
//       index.html
//       login.html
//       registro.html
//   /db
//     db.go
//   main.go

// e.GET("/users/:id", getUser)
func getUser(c echo.Context) error {
	// User ID from path `users/:id`
	id := c.Param("id")
	return c.String(http.StatusOK, id)
}

func withUser(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := context.WithValue(c.Request().Context(), "user", "a@gg.com")
		c.SetRequest(c.Request().WithContext(ctx))
		return next(c)
	}
}
