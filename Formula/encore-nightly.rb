class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230430"
    checksums = {
        "darwin_arm64" => "591c5efb85751aad168799cd1c3291c4d36e8b11a44d4e10875389d284c2e184",
        "darwin_amd64" => "3efff53f125d166e46c3f2a37c8b524206940dc3a70d2a3ff34179bfcb2af163",
        "linux_arm64"  => "e60e4ae1f645a3c3af64a5c873e30e852d4d6f92f0a55164a17e5ee564b4c94e",
        "linux_amd64"  => "d1a1713fd6c40e43fdd3128caff352b7c38d3678dadb43e6b48d5bc3c003015f",
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
