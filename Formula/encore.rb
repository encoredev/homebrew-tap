class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.14.2"
    checksums = {
        "darwin_arm64" => "d95f4c5132c3ccc8e1fab2d2021958dc62be3e70ce78c301f3ead7a135f8ba4f",
        "darwin_amd64" => "7260a39c8c32ff7c5a65a9ea8f412b9e965696feb4e4d13f4b1fb99340e80ef7",
        "linux_arm64"  => "7010e017401b3aa26ad20dae48fd3ad25494115f5f097b42a169371c485fe0d1",
        "linux_amd64"  => "e37bdac0ea551058bde7f9e0d21a4967967eebf88d7099d59212d1557a0c3421",
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
