class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.24.2-beta.2"
    checksums = {
        "darwin_arm64" => "b7d5fe0a54bd1cbae874a4fc885ed05a0c73ca94b290a50e8053bd878ff4cc32",
        "darwin_amd64" => "3f1c2818dd7e501f3b57a6c8832cbbbf5cc24774de5d3269dffbd063f202ae20",
        "linux_arm64"  => "b950a9730424c708a5d5a8b459f5aecc8833957a27a4bd0f2682dc5a304e780a",
        "linux_amd64"  => "3dd116ae1230ea1ff5029b1245c866564132a68f15544df261536a78a13c7371",
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
