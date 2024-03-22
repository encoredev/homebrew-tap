class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.3-beta.1"
    checksums = {
        "darwin_arm64" => "78d215614abec353f5dea4135fdfc1c51d396d14cd6b2c9a90a3df65384421ff",
        "darwin_amd64" => "cb8e110fc841618983f5b8345d6197a471eca68436c884e043ecbfa0371c0b01",
        "linux_arm64"  => "98c1298c965603aa223fb0446120e883d5d95017e5946215cd98a382844026cd",
        "linux_amd64"  => "4e438581606dc3510cbd3a687a27fc2afd2605bb73fb4837c2bef37320f0f231",
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
