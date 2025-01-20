class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.0"
    checksums = {
        "darwin_arm64" => "1a94a0fde969b85866f97ba7001d40aa9891ff79e2959d207c3ad955a5e19d3a",
        "darwin_amd64" => "d88d554f13c032f44f3dfed13850a1a70de45887d84497e1142038d23992ffbb",
        "linux_arm64"  => "e844068b922d6b869b02b7c07d49c356c44bdd1a6369263f6ac1476e3d95a5c5",
        "linux_amd64"  => "536d5fff74a7a26919d60d2eb6ac7f87024c821a6fa592b19a3c7f9ed8f77220",
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
