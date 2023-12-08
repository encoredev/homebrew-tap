class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.30.0-nightly.20231208"
    checksums = {
        "darwin_arm64" => "7594a19f3bb8bb7c7305a73f2f31b9f8570d92db95df998d6ced9a9d26ad8bbf",
        "darwin_amd64" => "2e01a349348912394c780f50ed8ac15c9ec785d8cabcf68de43051a0909377ca",
        "linux_arm64"  => "e3c86f5eacdb9a9ee0ac383b86e9796ea9e5e1b8cba9c3de4967c5067af233d0",
        "linux_amd64"  => "a2a4ccf1d7571982e649313ee414153ec7a0a315e316a2aa430dbabc39b1d94e",
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
