class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.36.5"
    checksums = {
        "darwin_arm64" => "d71e540eb5f62335eb5064416a2cd9f23706468e38df5e8ad2c75f56e69bd2a1",
        "darwin_amd64" => "db9aa467d3c20dd38842b7f4e2e66936119a1a41f694974b3f25f824e78fde7b",
        "linux_arm64"  => "1e3cf3d379d043e0e5548b12a3f6850c3639b660554ee24fe155b20d62395d33",
        "linux_amd64"  => "9ab38eb288093721955228ecfe20d025887e6b9f8002e381c14ceb0df91ecf14",
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
