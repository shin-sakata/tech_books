module Web.UserController
  ( userName
  , userNames
  )
where

import           Control.Monad.IO.Class         ( liftIO )
import qualified Repository.Users              as RU
import qualified Servant                       as SV

userName :: Int -> SV.Handler (Maybe String)
userName = liftIO . RU.runSelectById

userNames :: SV.Handler [String]
userNames = liftIO RU.runAllUsersName
