package main

import (
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	message := os.Getenv("MESSAGE")

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	r.GET("/api/v1/message", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": message,
		})
	})

	r.Run() // listen and serve on 0.0.0.0:8080
}
