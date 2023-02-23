class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.14.1"
    checksums = {
        "darwin_arm64" => "362c7bda8c5b921738574fcb74d746d463dd2b559f6479ab0c06ede6552777fa",
        "darwin_amd64" => "133b02e2a98faec21a582152bfadf15e2d9bf030cc3fbc5def761b0fc95e256d",
        "linux_arm64"  => "90f68890ac828e34a100d7b1caea98ba60280c86b315c58f76d2cbd54dbf831c",
        "linux_amd64"  => "284a4c4d63b1033f0d2b12bd0c3c0deaead9b4f9a9337f6bbf1d971957b2f376",
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
