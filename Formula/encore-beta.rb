class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-beta.12"
    checksums = {
        "darwin_arm64" => "08e6cd099cf1db63df039635fdaf182cc1e50c6b362e3eb1a6dde71ba141ef4f",
        "darwin_amd64" => "50172b78eaa1fb1343ee155a84dde000875b61e01ef94e527355f2b9c913e1d5",
        "linux_arm64"  => "d92c7cc6598f9539bdf10ea484af7b5cc8400672915968fc945f37a7ba805311",
        "linux_amd64"  => "52a438acee3cd8784137aebbd804dce12c85188ff38512fa23b864e58d49b137",
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
