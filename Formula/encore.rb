class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.9"
    checksums = {
        "darwin_arm64" => "ab6e584d6a8c0797b6e1465da3edc852d0555b0f7cd35c83c262eb8b64fe7d0e",
        "darwin_amd64" => "5527a04b3ea09b3a0308a15184d3e99632bbbe5bbbf4995776470160a95a331b",
        "linux_arm64"  => "a61baa979899d5c43c47ca0aeb8a929a6f3c38a9381b920eb9a5daa9dfa09676",
        "linux_amd64"  => "0529c2e4ea5eb9e00cb8b0cef2bee4219eb4b4c50c51a5dae036834eaddb3d83",
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
