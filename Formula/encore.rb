class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.10.6"
    checksums = {
        "darwin_arm64" => "2a10424119be80a2015a2f28573210fc2323ef244b22b9fe69f0cf2cc29c8a84",
        "darwin_amd64" => "d4cf0038fb29827169a49dfbae80a028b36b15986ce20e7b653b3429cb491033",
        "linux_arm64"  => "66cf84a4d0567c90e3b1a2c95a21b0ed6ccff04c4340d25ad64fa345a97f26d5",
        "linux_amd64"  => "162e4f2c7eea9b416d0ff82b8d0c28d27e406e57e60c235a9c18de6af6fc5b20",
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
