class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.5-beta.1"
    checksums = {
        "darwin_arm64" => "feb59688184e4a316613ba4a7c7e7a782465048d0d14e27de779c8b1db2ad84d",
        "darwin_amd64" => "5e919379872aa956d65507a3129d4c122894b21cec1b8bbafc4128c3cbaa031f",
        "linux_arm64"  => "50ce96fb49aea1a57df189c2d27effb260ded0479683f6e953d0df86e7c9247f",
        "linux_amd64"  => "50759b21c88a938ffce3b96e36ba6384fa8681d7a75319f505bb729679ca921e",
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
