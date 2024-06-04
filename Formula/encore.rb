class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.38.3"
    checksums = {
        "darwin_arm64" => "9dcb0ef76f251f1e0cfe45e6faf2f5c0a5eb03b85ed7a7adcbb299a215651bfb",
        "darwin_amd64" => "bcd5c1daefa044fa069e26c3cdbcda621f9baff2a53377670f180aa5978acd7d",
        "linux_arm64"  => "bcfe190033895c1ef05384506b65f655a158c694b41eb2ad1f32912863824c75",
        "linux_amd64"  => "443d7915c9f392212d09153243b339eb84f6283d5b45c4496be64c3ceecdacfc",
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
