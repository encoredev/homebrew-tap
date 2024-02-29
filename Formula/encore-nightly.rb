class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.0-nightly.20240229"
    checksums = {
        "darwin_arm64" => "3af53ee3c7adf28630cff62b10d93721e4f4c8b561813bf2e9b36ef061283d7b",
        "darwin_amd64" => "ee7aef720e8ea1689f1b1f11e02c30a90b1244bc3b48fc99bf002b21c8fe2bf1",
        "linux_arm64"  => "fef203dd16f5e86d23692417269629de1a9b2caf4eea47021b073424b6d0a1c0",
        "linux_amd64"  => "273ef3b3604830749444046ec71a91e91fa633c01619a9a7a61bd1a9f40e1ab8",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink libexec/"bin/encore-nightly"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "bash")
        (bash_completion/"encore-nightly").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "zsh")
        (zsh_completion/"_encore-nightly").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "fish")
        (fish_completion/"encore-nightly.fish").write output
    end

    test do
        system "#{bin}/encore-nightly", "check"
    end
end
