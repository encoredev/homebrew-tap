class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.22.1"
    checksums = {
        "darwin_arm64" => "41de0e3a95c0234edfe1846ae243ea64a5114eae96efdfbaf875c31c903cb5b5",
        "darwin_amd64" => "ebfc90506b718978a27e81abc081a0bc6d1514fee4c742ebb78cf816e4c102df",
        "linux_arm64"  => "fcd33dcb26bddba3f476192f5c3cbdaf831ac603b8a17eae9b1df06745e83b5a",
        "linux_amd64"  => "4ce0e174fde29de19cc458c31e2afd203f7c7c7a8d5bab50fc18918fa5b9bb15",
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
