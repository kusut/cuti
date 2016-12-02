{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}

module Lib
  ( startApp
  ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

data Employee = Employee
  { userId    :: Int
  , userName  :: String
  } deriving (Eq, Show)

$(deriveJSON defaultOptions ''Employee)

type API = "" :> Get '[JSON] [Employee]

startApp :: IO ()
startApp = run 8000 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = return employees

employees :: [Employee]
employees = [ Employee 1 "Isaac"
            , Employee 2 "Albert"
            ]

