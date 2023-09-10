package main

import (
	"html/template"
	"log"
	"net/http"
	"time"
)

var t = template.Must(template.ParseGlob("templates/*"))

func indexHandler(w http.ResponseWriter, r *http.Request) {
	t.ExecuteTemplate(w, "index.html", map[string]string{
		"Name": "fdsalfdsk"})
}

func clickedHandler(w http.ResponseWriter, r *http.Request) {
	err := t.ExecuteTemplate(w, "clicked.html", map[string]time.Time{
		"Time": time.Now(),
	})
	if err != nil {
		log.Printf("Something got wrong with clickedHandler, %s", err)
	}
}
func main() {
	static := http.FileServer(http.Dir("./static"))
	http.Handle("/static/", http.StripPrefix("/static/", static))
	http.HandleFunc("/clicked", clickedHandler)
	http.HandleFunc("/", indexHandler)

	http.ListenAndServe("0.0.0.0:8080", nil)
}
