module Repository.Users
  ( runSelectById
  , runAllUsersName
  )
where

import           Config.DataSource              ( connect )
import           Data.Functor.ProductIsomorphic.Class
                                                ( (|$|)
                                                , (|*|)
                                                )
import qualified Database.HDBC.Record          as Record
import           Database.Relational            ( (!)
                                                , (.=.)
                                                )
import qualified Database.Relational           as HRR
import qualified Entity.User                   as User

type DB a = IO a

runSelectById :: Int -> DB (Maybe String)
runSelectById n = do
  conn  <- connect
  users <- Record.runQuery conn (HRR.relationalQuery $ selectNameById n) ()
  return $ safeHead users
  where safeHead xs = if length xs /= 0 then Just (head xs) else Nothing

runAllUsersName :: DB [String]
runAllUsersName = do
  conn <- connect
  Record.runQuery conn (HRR.relationalQuery allUsersName) ()


selectNameById :: Int -> HRR.Relation () String
selectNameById n = HRR.relation $ do
  u <- HRR.query User.user
  HRR.wheres $ u ! User.id' .=. HRR.value n
  return $ u ! User.name'

allUsersName :: HRR.Relation () String
allUsersName = HRR.relation $ do
  u <- HRR.query User.user
  return $ u ! User.name'
