class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230824"
    checksums = {
        "darwin_arm64" => "3bca7bb7e9f3c680cc2ff00016169fd99df25c6e9d4d9650940e4ca8f991c7d3",
        "darwin_amd64" => "bebe8498979227288c0b67e51b2bd2439c48f35f28fbeba47f5b4998e285393f",
        "linux_arm64"  => "2db1c755360879dc1f8b2f06ae2567f815935b4116ed38e69fba9ca3cc4ef988",
        "linux_amd64"  => "d914b18de778a698d7cb21baaaacdb6ca9c6ef39108734f4b3227f55695d9d5f",
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
