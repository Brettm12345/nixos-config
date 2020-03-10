NIXOS_VERSION := 19.09
NIXOS_PREFIX := /etc/nixos

# The real Labowski
all:
	@sudo ./rebuild.sh switch

install: channels update config
	@sudo nixos-install

upgrade: update switch

update:
	@sudo nix-channel --update

switch:
	@sudo ./rebuild.sh switch

boot:
	@sudo ./rebuild.sh boot

rollback:
	@sudo ./rebuild.sh --rollback $(COMMAND)

dry:
	@sudo ./rebuild.sh dry-build --fast

gc:
	@nix-collect-garbage -d

clean:
	@rm -f result


# Parts
config: $(NIXOS_PREFIX)/configuration.nix


$(NIXOS_PREFIX)/configuration.nix:
	@sudo nixos-generate-config
	@echo "import /home/brett/src/github.com/brettm12345/nixos-config \"$$(hostname)\"" | sudo tee "$(NIXOS_PREFIX)/configuration.nix"


# Convenience aliases
i: install
s: switch
up: upgrade


.PHONY: config
