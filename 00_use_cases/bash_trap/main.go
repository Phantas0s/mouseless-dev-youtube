// This is a super server!
// To build it: go build -o super_server main.go

package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "This is THE server, yo!")
	})

	fmt.Println("Running THE Server, yo!")

	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
