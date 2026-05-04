class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.56.9"
    checksums = {
        "darwin_arm64" => "f626ce6e0cded1a8e1d4d9480d6e2308f53dc3d279bf56fd98b48a6ec4e82d37",
        "darwin_amd64" => "b5eaa464879d466409f1e5f4859a646957b1f640b5e73b3e0053a9692a4a6f77",
        "linux_arm64"  => "2e8feeea331c02e7fd21358f1c00d2a728c9d81b6e532bc7e7d5655555b96474",
        "linux_amd64"  => "b5c6b0115fe3faeb4df99b407bca3b43482f6cdfd645095e57c55e381eadff54",
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
