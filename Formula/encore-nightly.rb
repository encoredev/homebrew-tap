class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230112"
    checksums = {
        "darwin_arm64" => "497bf85626f601249847be878559e2e67e01714065c5d7ba8e4a557fdf6b7370",
        "darwin_amd64" => "eaeabc6c95fd8946ee1937e73acff80237c5a6e10a613107934e5be88ea2c2a6",
        "linux_arm64"  => "b055d2feefeb390f9c4a965c4ef5391d315d03b4d80674bdbdfd13baa7182aab",
        "linux_amd64"  => "8d8c1b43b0765564c28e861becc3bd3ed618dda0977ac09acaa0a9a6e2a448ac",
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
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
