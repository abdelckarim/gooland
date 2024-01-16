package handler

// Contiene los controladores para manejar las solicitudes HTTP. Aquí defines funciones que responden a las rutas de Echo.

import (
	"goland/model"
	"goland/templates/singles"

	"github.com/labstack/echo/v4"
)

type MemesHandler struct{}

func (h MemesHandler) SingleMeme(c echo.Context) error {

	wtf := c.Param("id")

	datos := model.Index{
		Get: wtf,
	}
	// return pgindex.indexTempl(datos).Render(c.Request().Context(), c.Response())
	return render(c, singles.ShowMeme(datos))
}

type NewsHandler struct{}

func (h NewsHandler) SingleNews(c echo.Context) error {

	wtf := c.Param("id")
	datos := model.Index{
		Get: wtf,
	}
	// return pgindex.indexTempl(datos).Render(c.Request().Context(), c.Response())
	return render(c, singles.ShowNews(datos))
}
