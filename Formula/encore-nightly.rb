class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.0-nightly.20240311"
    checksums = {
        "darwin_arm64" => "eb47b708d98a82e9f0f83fc07898ff7539627d052fb32648c5c2ec9b88893a91",
        "darwin_amd64" => "0f2006351a437b2210d452df9660dc1bb7495ddaf9c8481aeaf664935386741b",
        "linux_arm64"  => "51fecc23d3e191668e06b617050a12b7530165f5153045f8aca5f6d003ca1ac7",
        "linux_amd64"  => "2a826f4c5c9269c285a9e28bfb805fbec878400e0eb0bc3554cf759b1c340443",
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

        bin.install_symlink libexec/"bin/encore-nightly"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "bash")
        (bash_completion/"encore-nightly").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "zsh")
        (zsh_completion/"_encore-nightly").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "fish")
        (fish_completion/"encore-nightly.fish").write output
    end

    test do
        system "#{bin}/encore-nightly", "check"
    end
end
