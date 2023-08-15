class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230815"
    checksums = {
        "darwin_arm64" => "6579e272f70079ae3a6dd58e0740a8b5cd14f38614549ba2d4e138d19a960630",
        "darwin_amd64" => "f1033f86d5c492df2bdd47f9e06ac88f16d95bd99d8a6ab1bb773ad7bd5ba487",
        "linux_arm64"  => "a860a949fe94ca0622f90f236f96ac8bf6ca657e6d67711830b67e47eb1f10c9",
        "linux_amd64"  => "30052cd9e0d48ff0fc4496eb8870e8201c5c71c51c23425fe679e5f615c31a8f",
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
