module Repository.Users (runSelectById, runAllUsersName) where

import           Config.DataSource                    (connect)
import           Data.Functor.ProductIsomorphic.Class ((|$|), (|*|))
import           Database.HDBC.Record                 (runQuery)
import           Database.Relational
import qualified Entity.User                          as User

type DB a = IO a

runSelectById :: Int -> DB (Maybe String)
runSelectById n = do
  conn  <- connect
  users <- runQuery conn (relationalQuery $ selectNameById n) ()
  return $ safeHead users
  where safeHead xs = if length xs /= 0 then Just (head xs) else Nothing

runAllUsersName :: DB [String]
runAllUsersName = do
    conn <- connect
    runQuery conn (relationalQuery allUsersName) ()


selectNameById :: Int -> Relation () String
selectNameById n = relation $ do
  u <- query User.user
  wheres $ u ! User.id' .=. value n
  return $ u ! User.name'

allUsersName :: Relation () String
allUsersName = relation $ do
    u <- query User.user
    return $ u ! User.name'

