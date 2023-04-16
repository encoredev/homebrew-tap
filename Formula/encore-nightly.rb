class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230416"
    checksums = {
        "darwin_arm64" => "fdedd472beff204007cd967143b9925db3dee4407eaef0ab4766dee264a12ccf",
        "darwin_amd64" => "3341883ab4797080b9ff1c6012a6652ce9e5c681119272528b32d16785bf8b28",
        "linux_arm64"  => "f05b98a927eeb7e564f7f63d2b3fdb298bda5b54db2380e2893244ae6097df5b",
        "linux_amd64"  => "1276ff5f92713ccd0bbe0cf7f3d18d774b63711536101f7320a28c8685c63f0a",
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
