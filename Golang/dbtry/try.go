package dbtry

import (
	"database/sql"
	"fmt"
	"strconv"
	"strings"

	_ "github.com/lib/pq"
)

var p = fmt.Println

type User struct {
	Id       int
	Username string
}

type Userdata struct {
	User
	Name        string
	Secondname  string
	Description string
}

type DBConnection struct {
	hostname, username, password, dbName, sslMode string
	port                                          int
	connection                                    *sql.DB
}

func (c *DBConnection) DSName() string {
	return fmt.Sprintf(
		"host=%s port=%d user=%s password=%s dbname=%s sslmode=%s",
		c.hostname, c.port, c.username, c.password, c.dbName, c.sslMode,
	)
}

func (c *DBConnection) Close() error {
	err := c.connection.Close()
	return err
}

func CreateDBConneection(host, port, user, password, dbname string) (*DBConnection, error) {
	iport, err := strconv.Atoi(port)
	if err != nil {
		return nil, err
	}
	dbConnection := DBConnection{
		hostname: host,
		username: user,
		password: password,
		dbName:   dbname,
		port:     iport,
		sslMode:  "disable",
	}
	db, err := sql.Open("postgres", dbConnection.DSName())
	if err != nil {
		return nil, err
	}
	dbConnection.connection = db
	return &dbConnection, nil
}

func (c *DBConnection) exists(username string) (id int) {
	id = -1
	username = strings.ToLower(username)
	query := fmt.Sprintf(
		`SELECT "id" FROM "users" WHERE "username"='%s'`,
		username,
	)
	rows, err := c.connection.Query(query)
	if err != nil {
		p("Не удалось запустить запрос")
		return -1
	}
	defer rows.Close()
	for rows.Next() {
		err = rows.Scan(&id)
		if err != nil {
			p("Не удалось запустить Scan")
			return -1
		}
	}
	return
}

func (c *DBConnection) AddUser(d Userdata) int {
	d.Username = strings.ToLower(d.Username)
	already := c.exists(d.Username)
	if already != -1 {
		p("Пользователь уже существует")
		return -1
	}
	query := `INSERT INTO "users" ("username") VALUES ($1)`
	_, err := c.connection.Exec(query, d.Username)
	if err != nil {
		p("Не удалось выполнить вставку Exec в users")
		return -1
	}
	id := c.exists(d.Username)
	if id == -1 {
		p("Пользователь не существует после вставки")
		return id
	}
	query = `INSERT INTO "userdata" ("userid", "name", "secondname", "descr") VALUES ($1, $2, $3, $4)`
	_, err = c.connection.Exec(query, d.Id, d.Name, d.Secondname, d.Description)
	if err != nil {
		p("Не удалось выполнить вставку Exec в userdata")
		return -1
	}
	return id
}
