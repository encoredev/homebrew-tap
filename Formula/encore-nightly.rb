class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221229"
    checksums = {
        "darwin_arm64" => "1b1c747bc704bd04235686574c060d3b48b42ee8451b74dafefad1d07fd77dc2",
        "darwin_amd64" => "511b725c675cbd0af932a29c5fca2dd0cc1baeb51dea118157828805dd3513b4",
        "linux_arm64"  => "fce6155b055dc7c548090a304c7066ec3fabc5995f06a0e95a5c5459cd5b990e",
        "linux_amd64"  => "1263735ab3dc856e553777373ed9238933d27310a1c5d41cf1970300dc343006",
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
