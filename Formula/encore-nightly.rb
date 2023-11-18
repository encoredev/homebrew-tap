class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-nightly.20231118"
    checksums = {
        "darwin_arm64" => "9e2dc3f23ee9ecc3bcb2d1ef89a7dfb1f023074427eb4bbe8bc5dd434782314a",
        "darwin_amd64" => "1fc1da65033d4e36e3c84a5f86b7dee8ce81774c5524f19eb67629ca4c84899d",
        "linux_arm64"  => "d1566f2108ec0abb44961b0484381740af3fa570dfd4eb864fe179b91e388101",
        "linux_amd64"  => "357b841704ce8dd93d760d2da963977a183449026aa7ce4916ac9826ada471bb",
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
