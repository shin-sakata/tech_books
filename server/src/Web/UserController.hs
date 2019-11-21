module Web.UserController
    ( userName,
      userNames
    ) where

import           Control.Monad.IO.Class (liftIO)
import           Repository.Users       as Users
import           Servant                (Handler)

userName :: Int -> Handler (Maybe String)
userName = liftIO . Users.runSelectById

userNames:: Handler [String]
userNames = liftIO Users.runAllUsersName
