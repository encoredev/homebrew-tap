class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230811"
    checksums = {
        "darwin_arm64" => "3de9eea0b027232ced504e55ef58ec8b275355c669ef0d7f10bccdc938af9f41",
        "darwin_amd64" => "459b77df00a90f403733630b820615df7392cbf40c02a25497654d2b3be33bb1",
        "linux_arm64"  => "3b2ff025170ec8e86828aebcf62eaa0f2e2eba291463d09d954e72b756e2f31a",
        "linux_amd64"  => "8eaa72ef00d8bb27d3a4cea1ca66bacf3f5bcd93e02eeca88b5594046fc9a201",
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
