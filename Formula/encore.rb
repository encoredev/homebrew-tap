class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.39.3"
    checksums = {
        "darwin_arm64" => "291b599987e971825e9e582d409e3b4d29329278696626e739b6809b3369dc78",
        "darwin_amd64" => "c7073537021ed40df3fc82a29c65d5e1f04448972aa5b8a6d1adebe1a80feeee",
        "linux_arm64"  => "9842dd1bcfeb33ab21b90a7a93da1cb703ad847b8c7a335d2decebae87ec3aad",
        "linux_amd64"  => "7d681428d5bac539a44afb4eb0addc46a1faef2a23051aec79a9fa5cc8ad4b15",
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
