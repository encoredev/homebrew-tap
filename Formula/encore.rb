class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.57.2"
    checksums = {
        "darwin_arm64" => "e684e9276a04b88b649bb22cdc3ed2c07673c97d1da42a13988f4b6fcf62b8f8",
        "darwin_amd64" => "c0c66383c8b25facc688cbf6135733bd0198d2cd8fb4a59cd83e57c9d80047fc",
        "linux_arm64"  => "159bd9efecef0accb770374b71b47d91e3cde9c3c7d8cdec6ed1205fffbed001",
        "linux_amd64"  => "5cccb18c6e6e0660e6b730ecd503adc422af3b46c944383340186195aefd1963",
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
