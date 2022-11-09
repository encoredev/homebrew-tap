class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221109"
    checksums = {
        "darwin_arm64" => "64af5112dff5181588ef2768a8f2fc22d54f837fca558e02d318ff7d5ca48a86",
        "darwin_amd64" => "b224907aadf8938373a43c2bc363e45c6107a15c76182d8848d148915869deb9",
        "linux_arm64"  => "9499e4d99b6b0ba91bdfe558033b17f4a496f6ee62062cf696e7515fedd89375",
        "linux_amd64"  => "3c62e9e49bb19d3e2a736f2ca14135384065dc1f0cfcd0b0fc998f020f45e61c",
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
