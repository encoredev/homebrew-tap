class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230426"
    checksums = {
        "darwin_arm64" => "ab3c181fbd96984330c77f0e12692bc25842152f8d0a3e73148d28b56b242148",
        "darwin_amd64" => "d6d1fc1fc6a8f3539ae224606920aefa9b84a518c20eeff5431607ff3ecfe887",
        "linux_arm64"  => "480158b589192cd3058be8ec9f36a8fbe5d30a34ca00d06ef76c3b4ccaaf20d3",
        "linux_amd64"  => "a680e996e4045c0782669bc7a597a55dd428b7f002b7db429a5a3c0e472e4ac8",
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
