class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230527"
    checksums = {
        "darwin_arm64" => "842a1562f1e10900d252af765ddaaed4a5ddd1ca9ca90efc4baffc4b5d785b93",
        "darwin_amd64" => "4a2f52d4500c5a1c2838dde53fae515cd9402642003d336ae440cc28ba697c15",
        "linux_arm64"  => "9522fff103847d96d2799d93f8b0f7ca4ac63b17f7a3e7698cc8420312d69b65",
        "linux_amd64"  => "40da90a45fa3cf4811276ef3f89cd0422b117a989b598642f0faaabe3041f20e",
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
