module Config.Sqlite3
  ( defineTable
  )
where

import           Config.DataSource            (connect)
import           Data.Aeson                   (ToJSON)
import           Database.HDBC.Query.TH       (defineTableFromDB)
import           Database.HDBC.Schema.Driver  (typeMap)
import           Database.HDBC.Schema.SQLite3 (driverSQLite3)
import           GHC.Generics                 (Generic)
import           Language.Haskell.TH          (Dec, Q)

defineTable :: String -> Q [Dec]
defineTable tableName = defineTableFromDB
  connect
  (driverSQLite3 { typeMap = [("FLOAT", [t|Double|]), ("INTEGER", [t|Int|])] })
  "main"
  tableName
  [''Show, ''Generic, ''ToJSON]
