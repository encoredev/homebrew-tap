class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231020"
    checksums = {
        "darwin_arm64" => "8a03f527518a2cf5b4ee5ef464c849a0ec6181f085629106f421a0ce0da593a3",
        "darwin_amd64" => "270d29c32c9fcd9d147b8e21bcc5251211f800c6abc55e188c6e3cdf69fb0877",
        "linux_arm64"  => "63965c7ff03727b44ba3cccd937b0c469e604aa360ef6e9cea4739e5b4811487",
        "linux_amd64"  => "6f76df687a244c3b43d848cde1a853cc6cd85d18e0bb6e2829a5396fd983c680",
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
