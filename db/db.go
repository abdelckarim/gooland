// db/db.go
package db

import (
	"database/sql"
	"fmt"
	"time"

	"golang.org/x/crypto/bcrypt"
)

type DB struct {
	*sql.DB
}

type Version struct {
	VeID   int
	VeHash string
	VeDate time.Time
	// Agrega más campos según sea necesario
}

type User struct {
	UId      int    `json:"u_id"`
	UType    string `json:"u_type"`
	UNombre  string `json:"u_nombre"`
	UPwd     string `json:"u_pwd"`
	UEmail   string `json:"u_email"`
	UHash    string `json:"u_hash"`
	UAvatar  string `json:"u_avatar"`
	UIp      string `json:"u_ip"`
	UCreated string `json:"u_created"`
}

func New(connString string) (*DB, error) {
	db, err := sql.Open("mysql", connString)
	if err != nil {
		return nil, fmt.Errorf("error opening database: %w", err)
	}
	if err := db.Ping(); err != nil {
		return nil, fmt.Errorf("error connecting to database: %w", err)
	}
	return &DB{db}, nil
}

// GetVersion obtiene una versión por su ID
func (db *DB) GetVersion(id int) (*Version, error) {
	row := db.QueryRow("SELECT ve_id, ve_hash FROM versiones WHERE ve_id = ?", id)
	version := &Version{}
	err := row.Scan(&version.VeID, &version.VeHash)
	if err != nil {
		return nil, err
	}
	return version, nil
}

func (db *DB) GetAllVersions() ([]*Version, error) {
	rows, err := db.Query("SELECT ve_id, ve_hash FROM versiones")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var versions []*Version
	for rows.Next() {
		version := &Version{}
		if err := rows.Scan(&version.VeID, &version.VeHash); err != nil {
			fmt.Printf("Error scanning row: %v\n", err)
			return nil, err
		}

		fmt.Printf("ID: %d, Hash: %s\n", version.VeID, version.VeHash) // Imprimir cada versión
		versions = append(versions, version)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return versions, nil
}

// HashPassword hashes the password using bcrypt
func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

// InsertUser inserta un nuevo usuario en la base de datos
func (db *DB) InsertUser(user *User) error {
	// Hashear la contraseña
	hashedPassword, err := HashPassword(user.UPwd)
	if err != nil {
		return err
	}
	user.UPwd = hashedPassword

	// Insertar el usuario en la base de datos
	_, err = db.Exec("INSERT INTO usuarios (u_nombre, u_pwd, u_email) VALUES (?, ?, ?)", user.UNombre, user.UPwd, user.UEmail)
	if err != nil {
		return err
	}

	return nil
}

// UserExists comprueba si un usuario o un email ya existen en la base de datos
func (db *DB) UserExists(nombre, email string) (bool, error) {
	row := db.QueryRow("SELECT COUNT(*) FROM usuarios WHERE u_nombre = ? OR u_email = ?", nombre, email)
	var count int
	err := row.Scan(&count)
	if err != nil {
		return false, err
	}
	return count > 0, nil
}

// GetUserByName obtiene un usuario por su nombre
func (db *DB) GetUserByName(name string) (*User, error) {
	row := db.QueryRow("SELECT u_id, u_nombre, u_pwd FROM usuarios WHERE u_nombre = ?", name)

	user := &User{}
	err := row.Scan(&user.UId, &user.UNombre, &user.UPwd)

	fmt.Println(user)

	if err != nil {
		if err == sql.ErrNoRows {
			// No se encontró el usuario, devolver nil en lugar de un error
			return nil, nil
		}
		return nil, err
	}
	return user, nil

}

type UserData struct {
	ID     int
	Name   string
	Email  string
	Avatar sql.NullString
}

// GetUserByID obtiene un usuario por su ID
func (db *DB) GetUserByID(id int) (*UserData, error) {
	row := db.QueryRow("SELECT u_id, u_nombre, u_email, u_avatar FROM usuarios WHERE u_id = ?", id)

	user := &UserData{}
	err := row.Scan(&user.ID, &user.Name, &user.Email, &user.Avatar)

	if err != nil {
		if err == sql.ErrNoRows {
			// No se encontró el usuario, devolver nil en lugar de un error
			return nil, nil
		}
		return nil, err
	}
	return user, nil
}

// func (db *DB) GetAllUsers() ([]*UserData, error) {
// 	rows, err := db.Query("SELECT u_id, u_nombre, u_email, u_avatar FROM usuarios")
// 	if err != nil {
// 		return nil, err
// 	}
// 	defer rows.Close()

// 	var usersdatas []*UserData
// 	for rows.Next() {
// 		usersdata := &UserData{}
// 		if err := rows.Scan(&usersdata.ID, &usersdata.Name, &usersdata.Email, &usersdata.Avatar); err != nil {
// 			fmt.Printf("Error scanning row: %v\n", err)
// 			return nil, err
// 		}

// 		// fmt.Printf("ID: %d, Hash: %s\n", usersdata.VeID, usersdata.VeHash) // Imprimir cada versión
// 		usersdatas = append(usersdatas, usersdata)
// 	}

// 	if err := rows.Err(); err != nil {
// 		return nil, err
// 	}

// 	return usersdatas, nil
// }

func (db *DB) GetAllUsers(page int) ([]*UserData, error) {
	// Establece el tamaño de página a 10
	pageSize := 10

	// Calcula el offset
	offset := (page - 1) * pageSize

	rows, err := db.Query("SELECT u_id, u_nombre, u_email, u_avatar FROM usuarios LIMIT ? OFFSET ?", pageSize, offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var usersdatas []*UserData
	for rows.Next() {
		usersdata := &UserData{}
		if err := rows.Scan(&usersdata.ID, &usersdata.Name, &usersdata.Email, &usersdata.Avatar); err != nil {
			fmt.Printf("Error scanning row: %v\n", err)
			return nil, err
		}

		usersdatas = append(usersdatas, usersdata)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return usersdatas, nil
}
