class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.16.0"
    checksums = {
        "darwin_arm64" => "f0e1b41cbcc17da71cb8afa7e55e40b57e0a938e1328c671ed5651cbcd4c4f3f",
        "darwin_amd64" => "3db2aad16856183e8825b36185443ba8322defcadfe2a47da4af009f0c293bb6",
        "linux_arm64"  => "4dfd332ee6da4d7efd27d87613f354e7d2e9f5e77258590333cf7967cc7333b2",
        "linux_amd64"  => "ebae6f2d9d665309fe92033742efabd48772139d1bbc53f1ba734e409b802f6a",
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
