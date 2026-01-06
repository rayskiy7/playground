package main

import "github.com/rayskiy7/gostudy/dbtry"

func main() {
	db, _ := dbtry.CreateDBConneection(
		"localhost",
		"5432",
		"postgres",
		"password",
		"users",
	)
	db.AddUser(dbtry.Userdata{
		User: dbtry.User{4, "daShaMan"}, Name: "Darya", Secondname: "Belkova", Description: "The designer",
	})
	db.Close()
}
