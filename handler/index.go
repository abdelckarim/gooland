package handler

// Contiene los controladores para manejar las solicitudes HTTP. Aquí defines funciones que responden a las rutas de Echo.

import (
	"errors"
	"fmt"
	"goland/db"
	"goland/model"
	"goland/templates/index"
	"strconv"

	"github.com/dgrijalva/jwt-go"
	"github.com/labstack/echo/v4"
)

// JWT Custom Claims
type JwtCustomClaims struct {
	UId     int    `json:"u_id"`
	UNombre string `json:"u_nombre"`
	jwt.StandardClaims
}

// JWTClaims are the claims to be provided to JWT
type JWTClaims struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
	jwt.StandardClaims
}

type IndexHandler struct {
	DB *db.DB
}

func (h IndexHandler) HandlerIndex(c echo.Context) error {
	var userData model.UserData

	claims, _ := GetUserFromJWT(c) // Ignoramos el error
	if claims != nil && claims.ID != 0 {
		// Si no hay error y hay una ID, obtén los datos del usuario
		dbUserData, err := h.DB.GetUserByID(claims.ID)
		if err != nil {
			fmt.Println("Error al obtener los datos del usuario:", err)
		} else if dbUserData != nil {
			fmt.Println("Datos del usuario:", dbUserData)
			userData = model.UserData{
				ID:     dbUserData.ID,
				Name:   dbUserData.Name,
				Avatar: dbUserData.Avatar,
			}
		}
	}

	// Obtén el valor de page de la solicitud HTTP
	// pageStr := c.QueryParam("page")
	pageStr := "1"
	// Convierte el valor a int
	page, _ := strconv.Atoi(pageStr)
	// Pasa el valor a GetAllUsers
	allDbUsers, err := h.DB.GetAllUsers(page)
	if err != nil {
		fmt.Println("Error al obtener los datos del usuario:", err)
	}

	allUsers := make([]*model.UserData, len(allDbUsers))
	for i, dbUser := range allDbUsers {
		allUsers[i] = &model.UserData{
			ID:     dbUser.ID,
			Name:   dbUser.Name,
			Email:  dbUser.Email,
			Avatar: dbUser.Avatar,
			// Asegúrate de agregar aquí todos los campos necesarios
		}
	}

	datos := model.Index{
		Get:      "Juan",
		UserData: userData,
		AllUsers: allUsers, // Llena AllUsers con los datos de los usuarios
	}

	return render(c, index.ShowIndex(datos))
}

func GetUserFromJWT(c echo.Context) (*JWTClaims, error) {
	cookie, err := c.Cookie("jwt")
	if err != nil {
		return nil, err
	}

	token, err := jwt.ParseWithClaims(cookie.Value, &JWTClaims{}, func(token *jwt.Token) (interface{}, error) {
		return []byte("your-secret"), nil
	})
	if err != nil || !token.Valid {
		return nil, err
	}

	claims, ok := token.Claims.(*JWTClaims)
	if !ok {
		return nil, errors.New("No se pudieron leer los claims del token")
	}

	return claims, nil
}
