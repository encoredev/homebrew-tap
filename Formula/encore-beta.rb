class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.3-beta.1"
    checksums = {
        "darwin_arm64" => "eNIVYUq+w1P13qQTX9/BxR05bRTNayyakKPfZThEIf8=",
        "darwin_amd64" => "y44RD8hBYYmD9bg0XWGXpHHspoQ2yITgQ+y/oDccCwE=",
        "linux_arm64"  => "mMEpjJZWA6oiP7BEYSDog9XZUBfllGIVzZijgoRAJs0=",
        "linux_amd64"  => "TkOFgWBtw1EMvTpoeif8Kv0mBbtz+0g3wr7zcyDw8jE=",
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
