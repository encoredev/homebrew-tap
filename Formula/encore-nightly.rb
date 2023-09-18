class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230918"
    checksums = {
        "darwin_arm64" => "50cf1ad2bba9ce4ef69b70f204783566244f5bdcde5cb2edf49db602f2dbee8b",
        "darwin_amd64" => "5c87d3fae7606ff31745e10b08adb605daafb1d810e55f40a3d14709572e1b6b",
        "linux_arm64"  => "57cccb3294771e821bce0ea5624ece20ff2a27b75d8d5360ae91201cf60d35fa",
        "linux_amd64"  => "ff60b100730b00700b22bafd0b4b19d507db91b6794332806587e510d3666a75",
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
