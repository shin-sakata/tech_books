module Repository.Books
  ( runSelectById
  , allBooks
  , runInsertNewBook
  , ins
  , selectById
  )
where

import           Config.DataSource     (connect)
import           Database.HDBC.Record  (runInsert, runQuery)
import           Database.HDBC.Sqlite3 (Connection)
import           Database.Relational   (Insert, Relation, insert, query,
                                        relation, relationalQuery, value,
                                        wheres, (!), (.=.))
import           Entity.Book           (Book, NewBook, book)
import qualified Entity.Book           as Book

type Select a = Relation () a

runSelectById :: Int -> IO (Maybe Book)
runSelectById n = do
  conn  <- connect
  books <- runQuery conn (relationalQuery $ selectById n) ()
  return $ safeHead books
  where safeHead xs = if length xs /= 0 then Just (head xs) else Nothing

selectById :: Int -> Select Book
selectById n = relation $ do
  b <- query book
  wheres $ b ! Book.id' .=. value n
  return b

allBooks :: IO [Book]
allBooks = do
  conn <- connect
  runQuery conn (relationalQuery $ relation $ query book) ()


ins :: Insert NewBook
ins = insert Book.piNewBook

insertNewBook :: NewBook -> Connection -> IO Integer
insertNewBook nBook conn = runInsert conn ins nBook

runInsertNewBook :: NewBook -> IO Integer
runInsertNewBook nBook = do
  conn <- connect
  insertNewBook nBook conn
