class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.5"
    checksums = {
        "darwin_arm64" => "93d042d5ccd4b4a71d4e73db622ce802abf9fd64f1c9a6bd8720e1b8b8ed0c0f",
        "darwin_amd64" => "11c6739cc1627618bea6c17a57bcb38c9fb648fabd3b1be5b338e033afcc6c5e",
        "linux_arm64"  => "5489bc30f1e8b78ed9a1361af7687816852a23fc864ab559e6577b1194a9d10a",
        "linux_amd64"  => "91aff22681b454816f2e3ebf13af8a096e96619ec7e9cc938c35a2459f600de1",
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
