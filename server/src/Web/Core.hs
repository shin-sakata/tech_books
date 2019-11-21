module Web.Core
    ( startApp
    ) where

import           Entity.Book              (Book)
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant
import           Web.BookController       (book, books)
import           Web.UserController       (userName, userNames)

type API = "books" :> Get '[JSON] [Book]
    :<|> "books" :> Capture "id" Int :> Get '[JSON] (Maybe Book)
    :<|> "users" :> Get '[JSON] [String]
    :<|> "users" :> Capture "id" Int :> Get '[JSON] (Maybe String)

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = books
    :<|> book
    :<|> userNames
    :<|> userName
