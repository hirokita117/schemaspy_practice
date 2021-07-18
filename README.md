schemaspy を扱ってみたかったので作成したリポジトリ。  
まだ調整する必要がある箇所もあるけど、とりあえず作成は可能。

# Usage

```sh
# テーブル作成のSQLファイルを準備

$ touch hirokita_test_tables/any.sql

$ docker network create schemaspy_practice

$ make build

$ make push

$ make schemaspy
```
