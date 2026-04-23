class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.56.7"
    checksums = {
        "darwin_arm64" => "0c1cb21fdd9c0aa5bb8b1e53f089011b44d83a6108df75d438b64d02e76595ca",
        "darwin_amd64" => "de976d39a4e2a1576982056cb46a8a4345265ec701b772cdbac36b4640492540",
        "linux_arm64"  => "49fed88b790e4841ce67aa01527bf602f25cb65296fc3f137154cc9e339f623f",
        "linux_amd64"  => "e354b292e5cd3a1f0314a4c93ed5a184358d1462332e659f2e9c29a512b57ded",
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
