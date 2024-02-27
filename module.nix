{
  lib,
  stdenv,
  kernel,
}:

stdenv.mkDerivation {
  pname = "debugdriver";
  version = "1";

  src = ./src;

  nativeBuildInputs = kernel.moduleBuildDependencies;
  makeFlags = kernel.makeFlags ++ [ "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" ];

  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];
  installTargets = [ "modules_install" ];

  meta = {
    broken = !kernel.withRust;
    description = "A basic example of rust module";
    platforms = lib.platforms.linux;
  };
}
