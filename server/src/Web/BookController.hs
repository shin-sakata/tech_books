module Web.BookController
    ( book,
      books,
      insBook
    ) where

import           Control.Monad.IO.Class (liftIO)
import           Entity.Book            (Book, NewBook)
import           Repository.Books       as Books
import           Servant                (Handler)

book :: Int -> Handler (Maybe Book)
book = liftIO . Books.runSelectById

books :: Handler [Book]
books = liftIO Books.allBooks

insBook :: NewBook -> Handler Integer
insBook = liftIO . Books.runInsertNewBook
