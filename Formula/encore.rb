class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.23.1"
    checksums = {
        "darwin_arm64" => "3602686905755d566bbd2e540f5c52d7a31aeacd4978965684d7901f4858e2f6",
        "darwin_amd64" => "538306d9730e6682b1703fcf0e2f6000864717c47ab77235d9314d2a08fd7b01",
        "linux_arm64"  => "ecc614988f79fec3685a1a17643ca71fa576106a143c50b41ef589f5b35cd2c3",
        "linux_amd64"  => "3d2f54d267727fd8c1d4fbd4d417da328d437a1a21d263a1bd716c2ee047e819",
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
