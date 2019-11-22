module Entity.Book where

import           Config.DataSource                    (connect)
import           Data.Aeson                           (FromJSON, ToJSON)
import           Data.Functor.ProductIsomorphic.Class ((|$|), (|*|))
import           Database.HDBC.Query.TH               (defineTableFromDB',
                                                       makeRelationalRecord)
import           Database.HDBC.Schema.Driver          (typeMap)
import           Database.HDBC.Schema.SQLite3         (driverSQLite3)
import           Database.Relational.Pi               (Pi)
import           GHC.Generics                         (Generic)

-- import           Config.Sqlite3               (defineTable)
-- $(defineTable "book")

$(defineTableFromDB'
  connect
  (driverSQLite3 { typeMap = [("FLOAT", [t|Double|]), ("INTEGER", [t|Int|])] })
  "main"
  "book"
  [("id", [t|Int|]), ("has", [t|Bool|])]
  [''Show, ''Generic, ''ToJSON])

data NewBook = NewBook
  { ntitle :: !String
  , nurl   :: !String
  , nprice :: !Int
  , nhas   :: !Bool
  } deriving (Show, ToJSON, Generic, FromJSON)

makeRelationalRecord ''NewBook

piNewBook :: Pi Book NewBook
piNewBook = NewBook
  |$| #title
  |*| #url
  |*| #price
  |*| #has
