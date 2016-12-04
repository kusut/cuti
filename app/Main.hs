module Main where

import Network.Wai.Handler.Warp (run)
import Lib (app)

main :: IO ()
main = run 8000 app
