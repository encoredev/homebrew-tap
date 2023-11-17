class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-beta.4"
    checksums = {
        "darwin_arm64" => "fbab5c20cb5318b9aa73936de7640029473419eb01b6614295816672003382a6",
        "darwin_amd64" => "99a8124540dc489d34b26ba81ead4039007d61e6f67c69f9089b3b52c9621f65",
        "linux_arm64"  => "5f06abdff547bb7277abf71b25c28633636e41d003571e86bf1acac7908fcaf3",
        "linux_amd64"  => "de093a8b200f7d6a0ca2af57862cf9ae7b6158e9fefabfd711647989d6b69eae",
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
