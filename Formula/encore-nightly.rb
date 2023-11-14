class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231114"
    checksums = {
        "darwin_arm64" => "293c7d77cd81c4f9f4d3d066d0f8d01de42a3375401bd1aabbf9d0de938e5fca",
        "darwin_amd64" => "0b1d17459568b6f60bb46b60746f439d5c0cecb47abe633e23e45a5b597ef59f",
        "linux_arm64"  => "1ffcc40ce053bdd69e7825689d7d16de3e3a9a77b48c5ba5ec7a6fa415d8ab1b",
        "linux_amd64"  => "907a897a7e60f8197835a283c298f8e1d849ac44ed800843411bb05b564c4331",
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
