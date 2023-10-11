class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231011"
    checksums = {
        "darwin_arm64" => "be8ae4b020280595f2ee1827a7fa4e51e620a6de972425544694fd6388e0c621",
        "darwin_amd64" => "93c65521f4495f106e6da9c4b5318090c51ba56f4be70ba54a390fda8bef0633",
        "linux_arm64"  => "272bdcb4b7bf0c1df02c3a6897fd6fe5e19caf20af59ddf6c7b1beb51c477df3",
        "linux_amd64"  => "ee49eab3b705e9f81443411c7e6768af209a7e9f55e6595a3f008e33d728a0e9",
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
