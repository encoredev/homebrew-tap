class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-beta.9"
    checksums = {
        "darwin_arm64" => "aba1b70835fec54630879f3dc19cf728fb6a6a07fe1043e3b05f2601a5d29238",
        "darwin_amd64" => "311ba3f89f95b104802fdbf1b79a8664124c723bbb8801937b27f9777d0bdbe5",
        "linux_arm64"  => "74a7b04019ab7d783eff1bda4fd9848a395e4eb6cddac9cd56fee411916d7049",
        "linux_amd64"  => "38fbd54fadb1681fb9e014e5157a99f8ddb77cd9bc5b39cc788bdf1ed57ebb0d",
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
