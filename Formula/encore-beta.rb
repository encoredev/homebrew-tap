class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.1-beta.3"
    checksums = {
        "darwin_arm64" => "ed895ec9c45b94b853e78eb9b842cb96d7da4288df82d1ea359fed26be78a0c8",
        "darwin_amd64" => "1c856a88b19d4d12cc9f289c9e36a0876b23e0cbefe9247f481d4249d54b3de1",
        "linux_arm64"  => "0204e4ceadde9241e51ebc8d4e17ae0d739ae9a6a2decbb898407277f2613b8e",
        "linux_amd64"  => "edeabb52d2f3bff2f2b0f0da057c76573c2487e8a7e77fe43d4001e713b2ad1b",
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
