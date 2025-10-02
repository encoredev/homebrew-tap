class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.50.1"
    checksums = {
        "darwin_arm64" => "15ee97997e9625e26afb2b25308718386535790010346f56b0b23604802abfb6",
        "darwin_amd64" => "0d9bdf20ca167a4bd0e453d9bf69f8edacadad27d492e5e17c34050e1d81fe72",
        "linux_arm64"  => "18f0479ecd89e63d1839bce6266d14a28cfac072f057da8cb5c6c1aa6f1cc64e",
        "linux_amd64"  => "7cee8d3dc4750487cde10d2d12103c02b055435e0dc1dd2801bf6c5839a849fe",
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
