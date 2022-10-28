class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.9.4"
    checksums = {
        "darwin_arm64" => "ce8dc8be3c14cfe77643bd626ac337b372b140a3113656390b764df37ee94010",
        "darwin_amd64" => "3449cdedccc7b253478eb66bc609fd6d752cedb55975ba6d1a23ddc0f90688ef",
        "linux_arm64"  => "bce2978b46e667810337f39a44a81a7df8fb52ae0bba6756d7393ca4df0765ad",
        "linux_amd64"  => "aad65ffc8b17f941279e6ae9ed7c0b775213dfb82a9ddc83a7cdb06ab4ec15d0",
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
