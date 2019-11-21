module Entity.User where

import           Config.Sqlite3 (defineTable)

$(defineTable "user")
