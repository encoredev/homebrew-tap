class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.4-beta.5"
    checksums = {
        "darwin_arm64" => "3a7ce83bcd7dcd72b78628d8b9eb8699aeb4c9c57939ed4941a74de84654ece6",
        "darwin_amd64" => "11faf14fd51dafde89ad4f24871c7c60f16c1835046f7366838e09eb9d13d116",
        "linux_arm64"  => "117ee5cea6095abd20c331680d33da2c3c2823ae6891a47425e306e3b8dd4427",
        "linux_amd64"  => "beedca798dadceea576b4f5e8065de6cfb7bbc47ae5e41af1d929531a8dcfe0b",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
