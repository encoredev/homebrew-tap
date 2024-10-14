class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.12"
    checksums = {
        "darwin_arm64" => "c51f0537b46609859038bc5182b0cdf1fa7504be70064e8c05e0353fa6a2f5d5",
        "darwin_amd64" => "f34d6f398b302eb9091a27ea8bd2584f10e8f6204c8627a089d834b4fd1855a0",
        "linux_arm64"  => "061cab0b96b390ba3d525e5e9e7e9764390ff9d85e9b827a165c09bce96be8e4",
        "linux_amd64"  => "0437ccdce4b7be9bd431258bfb76f6feb20451723c2e813bd7349e75c3a57b70",
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
