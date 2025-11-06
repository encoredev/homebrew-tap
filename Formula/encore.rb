class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.51.5"
    checksums = {
        "darwin_arm64" => "6a5f2c6bad342c39d828163c6f575e96daef5798b2fc788f06bb051d87465e81",
        "darwin_amd64" => "c1560f0819b76176b5884ea1ae857cd2b851775414180119104aec1b28df5696",
        "linux_arm64"  => "aa7d333596825a50e56e9ccb1688150343dcb3fb24380dceafa9918c8f813b8a",
        "linux_amd64"  => "3b1c1ac0f74f030e378305938a8a7381126bee21e9ed96bfeb0835ef0b142d10",
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
