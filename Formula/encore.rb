class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.33.2"
    checksums = {
        "darwin_arm64" => "3b6571114ee83d4bc88b90849da3d03ab131f21ddf214997c2d85d99d6487481",
        "darwin_amd64" => "1573f875b72d3a66e53b4f8d070054cc37e1e2e90c537c2c0bfc93486a134d0a",
        "linux_arm64"  => "af37b060787a6bf56b42021fdaefd654d265facea83c1c4cd358ed8c87d977aa",
        "linux_amd64"  => "f354bb0b2eee5186503402d0958aa698ade28578566381b5b8b7730295f9c56c",
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
