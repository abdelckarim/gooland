// handler/handler.go
package handler

import (
	"goland/db"
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
)

type Handler struct {
	DB *db.DB
}

func (h *Handler) GetVersion(c echo.Context) error {
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		return c.JSON(http.StatusBadRequest, "ID must be an integer")
	}
	version, err := h.DB.GetVersion(id)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err)
	}
	return c.JSON(http.StatusOK, version)
}

func (h *Handler) GetAllVersions(c echo.Context) error {
	versions, err := h.DB.GetAllVersions()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err)
	}
	return c.JSON(http.StatusOK, versions)
}
