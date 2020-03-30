{ pkgs, ... }: {
  home-manager.users.brett = {
    home.file.".ghci".text = ''
      :set prompt  "\SOH\ESC]0;GHCi: %s\BEL\ESC[32;1m\STXλ>\SOH\ESC[0m\STX "
      :set prompt2                    "\SOH\ESC[32;1m\STX |\SOH\ESC[0m\STX "
      :set -package process
      :def paste \_ -> do { paste <- System.Process.readProcess "pbpaste" [] ""; let cmd = if '\n' `elem` paste then ":{\ntype Ö = ()\n" ++ paste ++ "\n:}" else paste in putStrLn ("\SOH\ESC[33m\STX" ++ paste ++ "\SOH\ESC[0m\STX") >> return (":cmd return " ++ show cmd) }
      :def paste-quiet \_ -> do { paste <- System.Process.readProcess "pbpaste" [] ""; let cmd = if '\n' `elem` paste then ":{\ntype Ö = ()\n" ++ paste ++ "\n:}" else paste in return (":cmd return " ++ show cmd) }
      :def hoogle     \str -> return $ ":! hoogle search --color --count=10 " ++ show str
      :def hoogle-all \str -> return $ ":! hoogle search --color "            ++ show str
      :def doc        \str -> return $ ":! hoogle search --color --info "     ++ show str
      :def pointfree \str -> return $ ":! pointfree " ++ show str
      :def pf        \str -> return $ ":! pointfree " ++ show str
      :def pointful  \str -> return $ ":! pointful " ++ show str
    '';

    home.packages = (with pkgs; [
      ctags
      cabal2nix
      cabal-install
      snack
      ghc
      # (all-hies.selection { selector = p: { inherit (p) ghc883; }; })
    ]) ++ (with pkgs.haskellPackages; [
      brittany # Haskell formatter
      ghcid # GHCi as a daemon
      hasktags # Produces ctags "tags" and etags "TAGS" files for Haskell programs
      hlint # linter
      hoogle # type signature search
      hpack # yaml based package format
      hspec # testing framework
      # pointfree # http://pointfree.io/
    ]);
  };
}
