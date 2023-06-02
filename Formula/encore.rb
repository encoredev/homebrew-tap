class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.20.0"
    checksums = {
        "darwin_arm64" => "29828f4f956a440c03a526a787e2b8c312949b09007afd7ccd2da7b3df9fcb5c",
        "darwin_amd64" => "626be775c6d2f0cd9640931ba9b1a0706cbf561d74ea37f4194ce8d92ebad1d8",
        "linux_arm64"  => "c8b95da12bf25f36d8775d97b75d3b792c41e5b69d1c524172f822adb1ab5cb4",
        "linux_amd64"  => "078e7dbc7ba08c457271556a06568c23563880ea60850d47eabf0b024056d4a4",
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
