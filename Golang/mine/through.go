package main

import (
	"fmt"
	"io/ioutil"
	"path/filepath"
)

func getFiles(dirname string) error {
	fmt.Println("directory:", dirname)
	files, err := ioutil.ReadDir(dirname)
	if err != nil {
		panic(err)
	}
	for _, file := range files {
		newfilename := filepath.Join(dirname, file.Name())
		if file.IsDir() {
			getFiles(newfilename)
		} else {
			fmt.Println("FILE:", newfilename)
		}
	}
	return nil
}

func main() {
	getFiles("recdir")
}
