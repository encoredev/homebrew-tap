class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.57.6"
    checksums = {
        "darwin_arm64" => "7f628b7e6eccc9019a29cd477e68ad49c2892272522c82ca9adf90baa6779fa2",
        "darwin_amd64" => "ca1d7e6c117051e774759cf75a5aa096ed079802857e8788170586f5c0651d79",
        "linux_arm64"  => "eecac1586ae61a0281b8fa9cb5e8af52a1998b6d1edd10e68a4e646a3c16c7ec",
        "linux_amd64"  => "ab8c496236079ca680e4267fcc54d0b18a3c6295fb0c42149c1e0da93dd676e0",
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
