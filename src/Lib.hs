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
      :<|> "employees" :> Capture "userId" Int :> Get '[JSON] Employee

api :: Proxy API
api = Proxy


employeeHandler :: Int -> Handler Employee
employeeHandler userId = return $ Employee userId "NO U"

employeesHandler :: Handler [Employee]
employeesHandler = return [Employee 1 "Fripp"]


server :: Server API
server = employeesHandler
    :<|> employeeHandler


app :: Application
app = serve api server
