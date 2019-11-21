module Repository.Books
  ( runSelectById
  , allBooks
  , DB
  )
where

import           Config.DataSource    (connect)
import           Database.HDBC.Record (runQuery)
import           Database.Relational
import           Entity.Book          (Book, book)
import qualified Entity.Book          as Book

type DB a = IO a

runSelectById :: Int -> DB (Maybe Book)
runSelectById n = do
  conn  <- connect
  books <- runQuery conn (relationalQuery $ selectById n) ()
  return $ safeHead books
  where safeHead xs = if length xs /= 0 then Just (head xs) else Nothing

selectById :: Int -> Relation () Book
selectById n = relation $ do
  b <- query book
  wheres $ b ! Book.id' .=. value n
  return b

allBooks :: DB [Book]
allBooks = do
  conn <- connect
  runQuery conn (relationalQuery $ relation $ query book) ()
