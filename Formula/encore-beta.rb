class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.3-beta.2"
    checksums = {
        "darwin_arm64" => "0bc0394c2d4f176d5f81ef85d9370e8dc3e9d471357816faf600bc8671991bb3",
        "darwin_amd64" => "82fe0e67f28d9b935d9c29ca68592f86c2e17f8a7236d835a8f98ec429a0fdcb",
        "linux_arm64"  => "c715416c75f50192127656f9897e29e280db087b7c0a9cafd31d32d08ed4ab19",
        "linux_amd64"  => "094be0c532b55daf356ff2b5290c1a8ae577503f8ad242f9700033c81f3f23d9",
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
