module Main where

import Control.Monad.Logger (runStderrLoggingT)
import Network.Wai.Handler.Warp (run)
import qualified Data.ByteString.Char8 as BS
import Data.Monoid ((<>))
import Database.Persist.Postgresql (
  ConnectionPool,
  ConnectionString,
  createPostgresqlPool,
  runSqlPool
  )
import Models (migrate)
import Lib (app)



connStr :: String -> ConnectionString
connStr sfx = (BS.pack "host=localhost dbname=cuti")
  <> (BS.pack sfx)
  <> (BS.pack " user=kingcrimson password=NingenIsu port=5432")

mkPool :: String -> IO ConnectionPool
mkPool str = runStderrLoggingT $ createPostgresqlPool (connStr str) 4

main :: IO ()
main = do
  pool <- mkPool ""
  runSqlPool migrate pool
  run 8000 app
