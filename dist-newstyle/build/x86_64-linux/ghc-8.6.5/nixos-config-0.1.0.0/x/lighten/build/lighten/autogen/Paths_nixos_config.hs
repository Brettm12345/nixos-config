{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_nixos_config (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/brett/.cabal/bin"
libdir     = "/home/brett/.cabal/lib/x86_64-linux-ghc-8.6.5/nixos-config-0.1.0.0-inplace-lighten"
dynlibdir  = "/home/brett/.cabal/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/brett/.cabal/share/x86_64-linux-ghc-8.6.5/nixos-config-0.1.0.0"
libexecdir = "/home/brett/.cabal/libexec/x86_64-linux-ghc-8.6.5/nixos-config-0.1.0.0"
sysconfdir = "/home/brett/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "nixos_config_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "nixos_config_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "nixos_config_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "nixos_config_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "nixos_config_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "nixos_config_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
