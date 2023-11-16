class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-beta.2"
    checksums = {
        "darwin_arm64" => "f4a9e9f276c0fcd5d487aa3be47ff33ff108882afb48bf0197295e93ca4737a9",
        "darwin_amd64" => "5e0c2b3c6e7975af1825da76cd3b126cd918d838511c2da47e05b617bb20f8d5",
        "linux_arm64"  => "3b13b25829fcb85ea333a33d4666d4922d532df2bf9cdd4168b540c6ef743819",
        "linux_amd64"  => "766a0f500e21dbeff2590fc9803784b2e3913061708c369f593858408b6ae707",
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
