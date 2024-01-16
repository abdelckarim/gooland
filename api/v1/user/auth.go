package user

import (
	"fmt"
	"net/http"
	"regexp"
	"time"

	"goland/db" // Asegúrate de importar tu paquete db correctamente

	"github.com/dgrijalva/jwt-go"
	"github.com/labstack/echo/v4"
	"golang.org/x/crypto/bcrypt"
)

// Usa el tipo User de db en lugar del tipo User local
type User = db.User

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

type Main_to_Auth struct {
	DB *db.DB
}

func RedirectIfAuthenticated(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		cookie, err := c.Cookie("jwt")
		if err == nil && cookie.Value != "" {
			token, err := jwt.ParseWithClaims(cookie.Value, &JWTClaims{}, func(token *jwt.Token) (interface{}, error) {
				return []byte("your-secret"), nil
			})
			if err == nil && token.Valid {
				return c.JSON(http.StatusForbidden, map[string]interface{}{
					"status":  http.StatusForbidden,
					"message": "Ya estás autenticado",
				})
			}
		}
		return next(c)
	}
}

// HashPassword hashes the password using bcrypt
func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

// CheckPasswordHash compares the hash with the password
func CheckPasswordHash(password, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

// Función auxiliar para generar respuestas de error
func errorResponse(c echo.Context, status int, message string) error {
	return c.JSON(status, map[string]interface{}{
		"status":  status,
		"message": message,
	})
}

// Register handles the registration of a new user
func Register(db *db.DB, c echo.Context) error {
	// 1. Extraer los datos del formulario del cuerpo de la solicitud
	user := new(User)
	if err := c.Bind(user); err != nil {
		return errorResponse(c, http.StatusBadRequest, "Error al vincular los datos del usuario")
	}

	// Obtener los datos del formulario POST
	user.UNombre = c.FormValue("u_nombre")
	user.UPwd = c.FormValue("u_pwd")
	user.UEmail = c.FormValue("u_email")

	// Ahora puedes acceder a los datos del formulario a través de la estructura User
	fmt.Println(user.UNombre)
	fmt.Println(user.UPwd)
	fmt.Println(user.UEmail)

	// Validar los datos del formulario
	if user.UNombre == "" || user.UPwd == "" || user.UEmail == "" {
		return errorResponse(c, http.StatusBadRequest, "Los campos de usuario, contraseña y email no pueden estar vacíos")
	}

	// Comprobar que el nombre de usuario es alfanumérico, sin espacios y tiene al menos 4 caracteres
	match, _ := regexp.MatchString(`^[a-zA-Z0-9]{4,}$`, user.UNombre)
	if !match {
		return errorResponse(c, http.StatusBadRequest, "El nombre de usuario solo puede contener caracteres alfanuméricos, no puede contener espacios y debe tener al menos 4 caracteres")
	}

	// // Comprobar que la contraseña tiene al menos 6 caracteres, y contiene al menos una letra mayúscula, una letra minúscula y un número
	// match, _ = regexp.MatchString(`^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$`, user.UPwd)
	// if !match {
	// 	return errorResponse(c, http.StatusBadRequest, "La contraseña debe tener al menos 6 caracteres, contener al menos una letra mayúscula, una letra minúscula y un número")
	// }

	// Comprobar que el email tiene un formato válido
	match, _ = regexp.MatchString(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`, user.UEmail)
	if !match {
		return errorResponse(c, http.StatusBadRequest, "El email no tiene un formato válido")
	}

	// 3. Comprobar si el usuario o el email ya existen en la base de datos
	exists, err := db.UserExists(user.UNombre, user.UEmail)
	if err != nil {
		return errorResponse(c, http.StatusInternalServerError, "Error al comprobar la existencia del usuario")
	}
	if exists {
		return errorResponse(c, http.StatusConflict, "El nombre de usuario o el email ya existen")
	}

	// 4. Guardar el nuevo usuario en la base de datos
	err = db.InsertUser(user)
	if err != nil {
		return errorResponse(c, http.StatusInternalServerError, "Error al insertar el usuario en la base de datos")
	}

	return c.JSON(http.StatusCreated, map[string]interface{}{
		"status":  http.StatusCreated,
		"message": "Usuario registrado con éxito",
	})
}

// Login handles the login of a user
func Login(db *db.DB, c echo.Context) error {
	// 1. Extraer los datos del formulario del cuerpo de la solicitud
	user := new(User)
	if err := c.Bind(user); err != nil {
		return errorResponse(c, http.StatusBadRequest, "Error al vincular los datos del usuario")

	}

	// Obtener los datos del formulario POST
	user.UNombre = c.FormValue("u_nombre")
	user.UPwd = c.FormValue("u_pwd")

	// Ahora puedes acceder a los datos del formulario a través de la estructura User
	// fmt.Println(user.UNombre)

	// 2. Comprobar si el usuario existe en la base de datos

	// Validar los datos del formulario
	if user.UNombre == "" || user.UPwd == "" {
		return errorResponse(c, http.StatusBadRequest, "Los campos de usuario y contraseña no pueden estar vacíos")
	}

	fmt.Println("Nombre: " + user.UNombre)

	dbUser, err := db.GetUserByName(user.UNombre)
	if err != nil {
		return errorResponse(c, http.StatusInternalServerError, "Error al buscar el usuario")
	}
	if dbUser == nil {
		return errorResponse(c, http.StatusUnauthorized, "Usuario o contraseña incorrectos")
	}

	// 3. Comprobar si la contraseña es correcta
	if err := bcrypt.CompareHashAndPassword([]byte(dbUser.UPwd), []byte(user.UPwd)); err != nil {
		return errorResponse(c, http.StatusUnauthorized, "Usuario o contraseña incorrectos")
	}

	// 4. Crear un nuevo token JWT y devolverlo en la respuesta JSON
	claims := &JWTClaims{
		ID:   dbUser.UId, // Asegúrate de que UId es el nombre correcto del campo para la ID del usuario en tu estructura de usuario
		Name: dbUser.UNombre,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Add(30 * 24 * time.Hour).Unix(),
		},
	}

	// La clave secreta que se utiliza para firmar el token JWT debe ser lo suficientemente larga y compleja para ser segura. Como mínimo, debería tener al menos 32 caracteres y debería ser una mezcla de letras mayúsculas y minúsculas, números y símbolos. No debe ser una cadena que se pueda adivinar fácilmente, como una palabra del diccionario.

	// Crear un nuevo token JWT
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	signedToken, err := token.SignedString([]byte("your-secret"))
	if err != nil {
		return errorResponse(c, http.StatusInternalServerError, "Error al crear el token")
	}

	// Crear una nueva cookie
	cookie := new(http.Cookie)
	cookie.Name = "jwt"
	cookie.Value = signedToken
	cookie.Expires = time.Now().Add(30 * 24 * time.Hour)
	cookie.HttpOnly = true
	// cookie.Secure = true // Descomenta esta línea cuando tu sitio esté en HTTPS
	cookie.Path = "/"

	// Establecer la cookie en la respuesta
	c.SetCookie(cookie)

	return c.JSON(http.StatusOK, map[string]interface{}{
		"status":  http.StatusOK,
		"message": "Usuario autenticado con éxito",
	})
}

// Reset handles the password reset of a user
func Reset(db *db.DB, c echo.Context) error {
	// TODO: Implementar la lógica de restablecimiento de contraseña aquí
	// 1. Extraer los datos del formulario del cuerpo de la solicitud
	// 2. Comprobar si el usuario existe en la base de datos
	// 3. Generar una nueva contraseña y hashearla
	// 4. Actualizar la contraseña del usuario en la base de datos
	// 5. Devolver una respuesta JSON
	return nil
}

// func GetUserFromJWT(c echo.Context) (*JWTClaims, error) {
// 	cookie, err := c.Cookie("jwt")
// 	if err != nil {
// 		return nil, err
// 	}

// 	token, err := jwt.ParseWithClaims(cookie.Value, &JWTClaims{}, func(token *jwt.Token) (interface{}, error) {
// 		return []byte("your-secret"), nil
// 	})
// 	if err != nil || !token.Valid {
// 		return nil, err
// 	}

// 	claims, ok := token.Claims.(*JWTClaims)
// 	if !ok {
// 		return nil, errors.New("No se pudieron leer los claims del token")
// 	}

// 	return claims, nil
// }

// func algunaFuncion(c echo.Context) {
// 	claims, err := GetUserFromJWT(c)
// 	if err != nil {
// 		// Manejar el error
// 	}

// 	// Usa 'claims' en alguna parte de esta función
// 	fmt.Println("ID del usuario:", claims.ID)
// 	fmt.Println("Nombre del usuario:", claims.Name)
// }
