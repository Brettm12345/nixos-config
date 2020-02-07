.PHONY: install result
install: result; SHELL=/bin/sh sudo $$PWD/switch $$PWD

secret.nix: secret.nix.gpg; gpg -dq $< > $@

result: secret.nix; ./build
