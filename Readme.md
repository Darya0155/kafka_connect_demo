```bash
docker-compose up
```

```bash
mysql -u admin -padmin
create schema msk_demo;
use msk_demo;
```
```bash
CREATE TABLE Persons (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255) NOT NULL, age INT);
```

```bash
INSERT INTO Persons (name, age) VALUES ('John', 30);
INSERT INTO Persons (name, age) VALUES ('Alice', 25);
```
```bash
UPDATE Persons SET age = 35 WHERE id = 1;
UPDATE Persons SET name = 'Bob' WHERE id = 2;
```

```bash
DELETE FROM Persons WHERE id = 1;
DELETE FROM Persons WHERE age = 25;
```

```bash
select * from Persons;

```


```curl
curl --location 'localhost:8083/connectors/' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data '{
    "name": "medium_debezium6",
    "config": {
        "connector.class": "io.debezium.connector.mysql.MySqlConnector",
        "database.hostname": "mysql-db",
        "database.port": "3306",
        "database.user": "<username>",
        "database.password": "<password>",
        "topic.prefix": "topic",
        "database.server.id":"12436",
        "database.include.list": "msk_demo",
        "database.history.kafka.bootstrap.servers": "kafka1:19092",
        "database.history.kafka.topic": "msk_demo.Persons",
        "schema.history.internal.kafka.topic": "msk_demo.Persons",
        "schema.history.internal.kafka.bootstrap.servers":"kafka1:19092",
        "table.include.list": "msk_demo.Persons"
    }
}'
```






```bash

mysqlbinlog  --read-from-remote-server --host=<host> --port=3306  --user <username> --password <password> --raw --verbose --result-file=/tmp/ <binlogfile>
```