class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231101"
    checksums = {
        "darwin_arm64" => "e24a3de96ec0219b281d280d92dfba4daf714749cc830b8ec967328ec652276b",
        "darwin_amd64" => "f1a93819a7c371d9a49076231ba9b9a6b0db80f35ed0d2a9175f2e5b2d25a39f",
        "linux_arm64"  => "8c7ba9509b75439e32727c27ed643b32238784213babfc12c64dde674c6b4c62",
        "linux_amd64"  => "b79794a16a4a88e2f8971f29307e53e35a57b898afba27b731c8d5a0999c9158",
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
