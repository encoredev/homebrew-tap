class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.38.0"
    checksums = {
        "darwin_arm64" => "8a8dfffefda6e54200c2dc3e5e50eae0668b2c4728c28bb2bab61fc4f017ac50",
        "darwin_amd64" => "55d1b21998c4712fb668769e28ca66d94dd13eab55825c9331c20fb5f96f42d5",
        "linux_arm64"  => "5ac0ec121b6885ffb730c781c470a8c4a702829f0b6179bfae5dc4b4e274e643",
        "linux_amd64"  => "425bb0f6c304c79947a61d609c1ddecebb8c4e78830708d9c4387c2c750963fb",
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
