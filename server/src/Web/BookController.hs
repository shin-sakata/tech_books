module Web.BookController
    ( book,
      books
    ) where

import           Control.Monad.IO.Class (liftIO)
import           Entity.Book            (Book)
import           Repository.Books       as Books
import           Servant                (Handler)

book :: Int -> Handler (Maybe Book)
book = liftIO . Books.runSelectById

books :: Handler [Book]
books = liftIO Books.allBooks
