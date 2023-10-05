class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231005"
    checksums = {
        "darwin_arm64" => "587a2d406bad53bd282d5f09de3a169bb923de571d197a67d74eacca53e9ade2",
        "darwin_amd64" => "cbb6a6d380245b6d4f3f5a2239a7853dfe189e188132bff5c507c4118b3f9ff6",
        "linux_arm64"  => "7da5adc58c5f8685a603fbf843b4112e574ce71798c991c80dd6830d9177c620",
        "linux_amd64"  => "c5017b01750320927ccb062aeeda34ed6c326b3328514bab190abbf1d02f25db",
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
