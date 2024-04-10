class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.9"
    checksums = {
        "darwin_arm64" => "b84fcb06f99dfb996d2cc158970fcc7e562fe3ad727fbd471cec6abcc318f39b",
        "darwin_amd64" => "6052487ddfbeaad5324bb7a91997bf85a2b56c2a5f8df09c1a251bfe302eb8ff",
        "linux_arm64"  => "f25d460bdcada8f0f1166fc0c6e102f4143b233cd09b1d921dd4f216daf136d0",
        "linux_amd64"  => "ed09b36c16bb8af52bdf4d74ab374a45eec4b712b1433d9210251c7e7af29861",
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
