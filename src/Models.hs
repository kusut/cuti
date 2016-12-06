{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Models where

import Data.Time (Day)
import Data.Aeson (FromJSON, ToJSON)
import Database.Persist.Sql
import Database.Persist.TH (
  mkMigrate, mkPersist, persistLowerCase,
  share, sqlSettings
  )


share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Employee json
    Id
    ein String maxlen=50
    name String
    email String
    joinDate Day
    UniqueEIN ein
    UniqueEmail email
    deriving Show
Leave json
    employee EmployeeId
    date Day
    Primary employee date
    deriving Show

|]

migrate :: SqlPersistT IO ()
migrate = runMigration migrateAll

