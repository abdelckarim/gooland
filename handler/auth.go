package handler

import (
	"goland/db"
	"goland/templates/user"

	"github.com/labstack/echo/v4"
)

type AuthHandler struct {
	DB *db.DB
}

func (data AuthHandler) LoginF(c echo.Context) error {

	return render(c, user.Login())

}

func (data AuthHandler) RegisterF(c echo.Context) error {

	return render(c, user.Register())

}

func (data AuthHandler) ResetF(c echo.Context) error {

	return render(c, user.Reset())

}
