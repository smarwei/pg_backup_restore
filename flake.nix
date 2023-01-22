{
  description = "A bash script that allows the user to backup and restore a specified PostgreSQL database with a timestamp in the backup file's name and command line parameters to display usage help text.";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation rec {
        name = "pg-backup-restore";
        src = self;
        buildInputs = [  postgresql ];
        # buildPhase = "gcc -o hello ./hello.c";
        installPhase = ''
          mkdir -p $out/bin
          install -t $out/bin pg_backup_restore.sh
        '';
      };

  };
}
