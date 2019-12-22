{-# LANGUAGE Arrows            #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Main(main) where

import           Control.Arrow
import           Control.Funflow
import           Control.Funflow.ContentHashable
import           Path
import           Path.IO
import           Control.Funflow.External.Nix
import           Text.URI.QQ

nixConfig :: (NixpkgsSource, Environment) -> NixConfig
nixConfig (nps, senv) =
  NixShellConfig {
    environment = senv
    , command = "jq"
    , args = [ParamText "--version"]
    , env = []
    , stdout = StdOutCapture
    , nixpkgsSource = nps
  }

jqVersion :: SimpleFlow NixpkgsSource String
jqVersion = proc np -> do
  cwd <- stepIO (const getCurrentDir) -< ()
  shellScript <- copyFileToStore
                    -< (FileContent (cwd </> [relfile|data/shell.nix|])
                                    ,[relfile|data/shell.nix|])
  readString_ <<< nix nixConfig -< (np, ShellFile shellScript)

jqVersionPkg :: SimpleFlow NixpkgsSource String
jqVersionPkg = readString_ <<< nix (\np -> nixConfig (np, PackageList ["jq"]))

tarballSource :: NixpkgsSource
tarballSource = NixpkgsTarball [uri|https://github.com/NixOS/nixpkgs/archive/a19357241973538212b5cb435dde84ad25cbe337.tar.gz|]

mainFlow :: SimpleFlow () (String, String)
mainFlow = proc _ -> do
  s1 <- jqVersion    -< tarballSource
  s2 <- jqVersionPkg -< NIX_PATH
  returnA -< (s1, s2)

main :: IO ()
main = do
    cwd <- getCurrentDir
    r <- withSimpleLocalRunner (cwd </> [reldir|funflow-example/store|]) $ \run ->
      run mainFlow ()
    case r of
      Left err ->
        putStrLn $ "FAILED" ++ show err
      Right out -> do
        putStrLn $ "SUCCESS"
        print out
