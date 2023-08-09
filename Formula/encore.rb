class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.24.1"
    checksums = {
        "darwin_arm64" => "fed51efa9c2f95e3bf2802388b99d78515a0e0266221b5752978d0161737602f",
        "darwin_amd64" => "d136d1da0d4e1e7b69e8034957a202862841ca5bc1e8e85377770c17f7cbbcd4",
        "linux_arm64"  => "7a321b4562f76cf7887deb998bf193000ce22ce24a8947fdf79ac407bbfb90c2",
        "linux_amd64"  => "97c3d3a5f1dda53053a6f656725a3a06154f041cf9406d265455745534c354b7",
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
