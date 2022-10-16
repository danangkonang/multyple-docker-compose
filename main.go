package main

import (
	"encoding/json"
	"log"
	"net/http"
)

type Response struct {
	Status  int         `json:"status"`
	Message string      `json:"message"`
	Data    interface{} `json:"data,omitempty"`
}

func makeRespon(w http.ResponseWriter, status int, msg string, res interface{}) {
	w.Header().Set("Content-type", "application/json")
	var response Response
	response.Status = status
	response.Message = msg
	response.Data = res
	userJson, _ := json.Marshal(response)
	w.WriteHeader(status)
	w.Write(userJson)
}

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		makeRespon(w, 200, "helo word v3", nil)
	})
	log.Fatal(http.ListenAndServe(":3000", nil))
}
