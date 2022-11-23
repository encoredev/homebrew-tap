class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221123"
    checksums = {
        "darwin_arm64" => "72a29045299b35f1e04e3e5a7b824b29b4e0f15469b33966c97fffada49b8fa2",
        "darwin_amd64" => "f7caf6ce2709bd97410d0c8320ac55ff3ca756695b5493e7a8f081702e30963c",
        "linux_arm64"  => "5581893225ca547740205f5536b58fb1b2a7bdeaedd5e089ecadb10aad261bfc",
        "linux_amd64"  => "8bb12a3b8c996af45489f922cae48dfbee57cb071a713fe1cc8177ba936102b7",
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
