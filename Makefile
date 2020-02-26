.PHONY: install result
install: result; SHELL=/bin/sh sudo $$PWD/switch.sh $$PWD
boot: result; SHELL=/bin/sh sudo $$PWD/switch.sh $$PWD

secret.nix: secret.nix.gpg; gpg -dq $< > $@

result: secret.nix; ./build.zsh
