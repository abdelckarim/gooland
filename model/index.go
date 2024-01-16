package model

import "database/sql"

// Define las estructuras de datos (por ejemplo, estructuras de Go) que representan tu modelo de negocio o los objetos que manipulará tu aplicación.

type Index struct {
	Get      string
	UserData UserData
	AllUsers []*UserData // Agrega este campo
}

type UserData struct {
	ID     int
	Name   string
	Email  string
	Avatar sql.NullString
}
