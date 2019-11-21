module Config.DataSource
  ( connect
  )
where

import           Database.HDBC.Sqlite3 (Connection, connectSqlite3)

-- コネクションを得る関数
connect :: IO Connection
connect = connectSqlite3 "books.db"
