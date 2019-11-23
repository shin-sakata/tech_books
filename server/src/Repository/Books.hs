module Repository.Books
  ( runSelectById
  , allBooks
  , runInsertNewBook
  )
where

import qualified Config.DataSource             as DS
import qualified Database.HDBC.Record          as Record
import qualified Database.HDBC.Sqlite3         as Sqlite3
import qualified Database.HDBC                 as HDBC
import qualified Database.Relational           as HRR
import           Database.Relational            ( (.=.)
                                                , (!)
                                                )
import qualified Entity.Book                   as Book
import qualified Entity.NewBook                as NBook
import qualified Control.Exception             as Exception
import           System.IO                      ( hPrint
                                                , hPutStrLn
                                                , stderr
                                                )

type Select a = HRR.Relation () a

runSelectById :: Int -> IO (Maybe Book.Book)
runSelectById n = do
  conn  <- DS.connect
  books <- Record.runQuery conn (HRR.relationalQuery $ selectById n) ()
  return $ safeHead books
  where safeHead xs = if length xs /= 0 then Just (head xs) else Nothing

selectById :: Int -> Select Book.Book
selectById n = HRR.relation $ do
  b <- HRR.query Book.book
  HRR.wheres $ b ! Book.id' .=. HRR.value n
  return b

allBooks :: IO [Book.Book]
allBooks = do
  conn <- DS.connect
  Record.runQuery conn
                  (HRR.relationalQuery $ HRR.relation $ HRR.query Book.book)
                  ()

insertNewBook :: NBook.NewBook -> Sqlite3.Connection -> IO Integer
insertNewBook nBook conn = Record.runInsert conn ins nBook
  where ins = HRR.insert NBook.piNewBook

runInsertNewBook :: NBook.NewBook -> IO Integer
runInsertNewBook nBook = do
  conn <- DS.connect
  HDBC.withTransaction conn $ \c ->
    insertNewBook nBook c `Exception.catch` \e -> do
      hPrint stderr (e :: HDBC.SqlError)
      return 0
