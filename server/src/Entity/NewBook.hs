module Entity.NewBook where
  
import           Data.Aeson                           (FromJSON, ToJSON)
import           Data.Functor.ProductIsomorphic.Class ((|$|), (|*|))
import           Database.HDBC.Query.TH               (makeRelationalRecord)
import           Database.Relational.Pi               (Pi)
import           GHC.Generics                         (Generic)
import           Entity.Book (Book)

data NewBook = NewBook
  { title :: !String
  , url   :: !String
  , price :: !Int
  , has   :: !Bool
  } deriving (Show, ToJSON, Generic, FromJSON)

makeRelationalRecord ''NewBook

piNewBook :: Pi Book NewBook
piNewBook = NewBook
  |$| #title
  |*| #url
  |*| #price
  |*| #has

  -- curl -X POST -H "Content-Type: application/json" -d '{"title":"postTest", "url":"posttest-url.com", "price": 12345, "has": false}' localhost:8080/books