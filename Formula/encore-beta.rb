class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.1-beta.1"
    checksums = {
        "darwin_arm64" => "e007d13edbee66404826ae5e549c4811bca62bd4d4a7cc5d1e0e0be039587a91",
        "darwin_amd64" => "371396701d771eec7ed0d8e4459767aadad9979d35ee3402173d36a1c7330f3b",
        "linux_arm64"  => "dcbd43c3886c8d2426704d3eb61f5070b49e3e7569783097893bd41ab8e3d829",
        "linux_amd64"  => "1e5d32bf97ba6e9c2e45255ef944ad763ee5694818bc26e6e9f1abbd5b45aa31",
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
