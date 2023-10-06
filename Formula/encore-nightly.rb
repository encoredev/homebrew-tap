class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231006"
    checksums = {
        "darwin_arm64" => "30f72df4a9bdccdb3177c86d8700ce92d496c94238285afb168ffb4b3b07e8f8",
        "darwin_amd64" => "adbfb5459081e30fd357a900a567dfea76b9cc871272e2e22a10e59320e88429",
        "linux_arm64"  => "33a8653d73db56d173e073981ed525d9f7837dca7f1e1396a3573ef9ab4c1374",
        "linux_amd64"  => "bf121799d893b6845cf7a0da1d000306185d585db81dd87a1127f93c6b26bd25",
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
