class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.5"
    checksums = {
        "darwin_arm64" => "ef9d9d77969999c8f8636e91ef1afd9c11a37d87dc3a75cb941a149f0470f207",
        "darwin_amd64" => "eaffe1201134cb3e4203e44e6fa16c9b6bb8e94ceaaf8927ad75a238dd10c017",
        "linux_arm64"  => "7fe124bb69b2227943fa9426f6174bca2c01ba2bc2b389dbd19a2830b08e9ee4",
        "linux_amd64"  => "1d56f2d28eb9841021e723c239402dcf44b38f117cfa04ce32e78f8f485b7fef",
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
