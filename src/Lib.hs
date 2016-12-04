{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}

module Lib
  ( app
  ) where

import Data.Aeson
import Data.Aeson.TH
import Servant

data Employee = Employee
  { userId    :: Int
  , userName  :: String
  } deriving (Eq, Show)

$(deriveJSON defaultOptions ''Employee)




type API = "employees" :> Get '[JSON] [Employee]

api :: Proxy API
api = Proxy

server :: Server API
server = return employees

employees :: [Employee]
employees = [Employee 1 "Fripp"]


app :: Application
app = serve api server
