build:
	TMPDIR=/var/tmp/ nix build -L --show-trace ./#nixosConfigurations.vm.config.system.build.vm
