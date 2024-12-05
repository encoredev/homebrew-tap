class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.10"
    checksums = {
        "darwin_arm64" => "cef3976550e8019dbd43d5da5820daab078dd1083494945db2a67ed2a08f32fc",
        "darwin_amd64" => "83197be875dbe3e382b2e7aa19c99047e63756e2422161b9b7016fbb3fea1c97",
        "linux_arm64"  => "2a73225ead5e9e53a05929e69a2f4451cf9c40598bb55f8cdaa4578502afba66",
        "linux_amd64"  => "c3cd691d96e80aea563974baa406a91b2fad0b8448b298180dc6f0adbcbf8f2f",
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
