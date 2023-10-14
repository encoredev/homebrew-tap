class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231014"
    checksums = {
        "darwin_arm64" => "4f9103ccacce5198a923e388ea33e67cc366bf7570125085e67074cf4af1f8cd",
        "darwin_amd64" => "9172bbf233d36ab495222a69bb3b9014ba29ea57b68080973debc37753a14940",
        "linux_arm64"  => "a339bf8f41fb2a607753a883fff0aec39c81b103481181c30c5a19208870aab2",
        "linux_amd64"  => "d6cfd00d64ad98923be51d27c1f6c83448b0f5b4826271524d904fad4df6ec9c",
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
