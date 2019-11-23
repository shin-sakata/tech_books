module Web.BookController
  ( book
  , books
  , insBook
  )
where

import           Control.Monad.IO.Class         ( liftIO )
import qualified Entity.Book                   as Book
import qualified Entity.NewBook                as NB
import qualified Repository.Books              as RB
import qualified Servant                       as SV

book :: Int -> SV.Handler (Maybe Book.Book)
book = liftIO . RB.runSelectById

books :: SV.Handler [Book.Book]
books = liftIO RB.allBooks

insBook :: NB.NewBook -> SV.Handler Integer
insBook = liftIO . RB.runInsertNewBook
