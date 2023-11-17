class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-beta.5"
    checksums = {
        "darwin_arm64" => "9b911d0ab133a6bd85d5bbe168b01b77f6bef23d0576ec48933da0b993945e0a",
        "darwin_amd64" => "78e84197c63c3b6723045d5e4c5429423c117dace2ec8a5ea4c91a20fece2f23",
        "linux_arm64"  => "1a7b66848c17d37739a45b4c5e1b68e4e43f54af7b0fa984ec92ce209fdb0162",
        "linux_amd64"  => "afe2ac2c53683d8fd17d53c6a9c8c89827b6c34e718f30cd76e6616fe506838c",
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
