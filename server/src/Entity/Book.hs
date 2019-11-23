module Entity.Book where

import qualified Config.DataSource             as DS
import           Data.Aeson                     ( FromJSON
                                                , ToJSON
                                                )
import           Database.HDBC.Query.TH         ( defineTableFromDB'
                                                , makeRelationalRecord
                                                )
import           Database.HDBC.Schema.Driver    ( typeMap )
import           Database.HDBC.Schema.SQLite3   ( driverSQLite3 )
import           GHC.Generics                   ( Generic )

$(defineTableFromDB'
  DS.connect
  (driverSQLite3 { typeMap = [("FLOAT", [t|Double|]), ("INTEGER", [t|Int|])] })
  "main"
  "book"
  [("id", [t|Int|]), ("has", [t|Bool|])]
  [''Show, ''Generic, ''ToJSON])
