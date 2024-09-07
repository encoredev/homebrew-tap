class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.40.5"
    checksums = {
        "darwin_arm64" => "fd9505f8470e2794a2acb796ae8634043d6b325e5c15e06b1676802fbfad734c",
        "darwin_amd64" => "519349c5f36cd9073c7eeb5c6d80892258face80ca3581f80637f405bbee95c6",
        "linux_arm64"  => "d200b552cf07a3601ef756bb8cf1542597d18d8d7ff4494d7260dcc0cee4d79b",
        "linux_amd64"  => "08cf71c36dca5ed0a41e7cce583c817c545ae13cbe2914550e24cefec52ba54a",
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
