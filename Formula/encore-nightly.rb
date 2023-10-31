class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231031"
    checksums = {
        "darwin_arm64" => "a2d061ba8a99e3c293e38309f62cff44ca13b81130d8efb22de1706f15abca8c",
        "darwin_amd64" => "86b81ffc34cf46c46b0133db4594c028a77b58fef0e8b1627e22ce3f1be85458",
        "linux_arm64"  => "e2eb8b1f7f71d0b6db2a49341cc59f3a4cc5f68b0f88d2c4323581fbcf979d4c",
        "linux_amd64"  => "206b2cdf38babfaa57eb4ab7ccec159331273e5556e16d0881fe92c3245f2a2b",
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
