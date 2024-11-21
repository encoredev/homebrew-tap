class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.4"
    checksums = {
        "darwin_arm64" => "6b11e5a7833355e2470da77708ec3d4ea29a222dd9e62072b3a71a9c96727883",
        "darwin_amd64" => "a446c9b5c8c8cb5c0e09cff3b3c01c3cd07af00bda58b236205d9e64d6b5c6d5",
        "linux_arm64"  => "e4224a1afb3a9fe3cdcc1d550d0a941f3f146d91676028ccc9e602931c5c31de",
        "linux_amd64"  => "5776ff9aaf2f253d4b2cf5b55de128f38c7efc0dcab39732ed4e6da316d8ed3a",
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
