class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221223"
    checksums = {
        "darwin_arm64" => "3314c7e6c072a95b77c1b5c97e510899c5824d7967e95a50c685cc0a0f063ee6",
        "darwin_amd64" => "15e713e58429bfaf7ba2c46a59291892c573cf58a165c170615d1eb2e34bdead",
        "linux_arm64"  => "1edcf5b47f0f928ac87d371e32be22475876ce3fbaa52c30792ced1768d87b17",
        "linux_amd64"  => "c9a7a39e28d1e40234f8d4109c8e4a8d26e1df11f80738d7ce614073bf92d13b",
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
