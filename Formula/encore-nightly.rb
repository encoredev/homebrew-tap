class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230302"
    checksums = {
        "darwin_arm64" => "b66ae4e5ad2bd939305185fc0f060ea58c544813332b254a9857fdd13333adcd",
        "darwin_amd64" => "aa2fa288dc7690a3be2efd510dbafbe7a9c61869eadcffa5ef3aac02bc3f2009",
        "linux_arm64"  => "5621c16792a2e4fee8f8a7565ccf62372c37a772e1060dba04b36e0ac7e6e63f",
        "linux_amd64"  => "442d2fef90c0bd7ede6bd6ba3c6535ffdc349dec958b8650031e30b49667e3ec",
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
