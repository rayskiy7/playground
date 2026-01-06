package main

import (
	"bufio"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"os"
)

type SigStruct struct {
	Count      int
	Signatures []string
}

func check(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func getStrings(filename string) []string {
	var lines []string
	file, err := os.Open(filename)
	if os.IsNotExist(err) {
		return nil
	}
	check(err)
	defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	check(scanner.Err())
	return lines
}

func appendRecord(filename string, data string) {
	options := os.O_WRONLY | os.O_APPEND | os.O_CREATE
	file, err := os.OpenFile(filename, options, os.FileMode(0600))
	check(err)
	_, err = fmt.Fprintln(file, data)
	check(err)
	err = file.Close()
	check(err)
}

func mainHandler(writer http.ResponseWriter, request *http.Request) {
	html, err := template.ParseFiles("view.html")
	check(err)
	signatures := getStrings("signatures.txt")
	err = html.Execute(writer, SigStruct{
		Count:      len(signatures),
		Signatures: signatures,
	})
	check(err)
}

func newHandler(writer http.ResponseWriter, request *http.Request) {
	html, err := template.ParseFiles("new.html")
	check(err)
	err = html.Execute(writer, nil)
	check(err)
}

func appendHandler(writer http.ResponseWriter, request *http.Request) {
	newSignature := request.FormValue("signature")
	appendRecord("signatures.txt", newSignature)
	http.Redirect(writer, request, "/guestbook", http.StatusFound)
}

func main() {
	http.HandleFunc("/guestbook", mainHandler)
	http.HandleFunc("/guestbook/new", newHandler)
	http.HandleFunc("/guestbook/append", appendHandler)
	err := http.ListenAndServe(":8080", nil)
	log.Fatal(err)
}
