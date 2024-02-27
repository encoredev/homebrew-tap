class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.31.2-beta.3"
    checksums = {
        "darwin_arm64" => "22213334db837f7b8aa3c6dd8702145c3ae8c4e2b2ff20e26060a5e43fe3db93",
        "darwin_amd64" => "b2a309f7290ab5a500a59862ef030267e339efa7dfa26bffa6480f6f696d0b1e",
        "linux_arm64"  => "5f43b4706feae7e5412ab6a19d694a1298521a515fddc29dd4e4b75e7f0faa0c",
        "linux_amd64"  => "25eeba7e176390fe484bd92db576f5d89e6a7b94819c0790b2f268fe2689ff60",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
