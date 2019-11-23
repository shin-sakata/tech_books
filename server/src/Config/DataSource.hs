module Config.DataSource
  ( connect
  )
where

import qualified Database.HDBC.Sqlite3         as Sqlite3


-- コネクションを得る関数
connect :: IO Sqlite3.Connection
connect = Sqlite3.connectSqlite3 "books.db"
