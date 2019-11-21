module Entity.Book where

import           Config.DataSource            (connect)
import           Data.Aeson                   (ToJSON)
import           Database.HDBC.Query.TH       (defineTableFromDB')
import           Database.HDBC.Schema.Driver  (typeMap)
import           Database.HDBC.Schema.SQLite3 (driverSQLite3)
import           GHC.Generics                 (Generic)

-- import           Config.Sqlite3               (defineTable)
-- $(defineTable "book")

$(defineTableFromDB'
  connect
  (driverSQLite3 { typeMap = [("FLOAT", [t|Double|]), ("INTEGER", [t|Int|])] })
  "main"
  "book"
  [("id", [t|Int|]), ("has", [t|Bool|])]
  [''Show, ''Generic, ''ToJSON])
