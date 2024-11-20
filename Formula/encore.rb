class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.3"
    checksums = {
        "darwin_arm64" => "003c38e76f312bf5671bfbce1c7d7ed594b50085161a82705b98aec2c2324758",
        "darwin_amd64" => "8a9921ce71842bc0a88bb3848aeb0effb5bd4edcc8fd8d48070c63dcb51e0930",
        "linux_arm64"  => "9732d7f3cb9aac80269abbdff4f6773688d53cf12f1484a7f6005c7ea487f1d4",
        "linux_amd64"  => "496f6bc19de63a1261ec921cc710af39142c3e7cc426fd10b679a9f68a074fd1",
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
