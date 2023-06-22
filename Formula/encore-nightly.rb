class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230622"
    checksums = {
        "darwin_arm64" => "cfb3bbb0ae180dc696e18cc0d048299da5e8f96b9898870ed1ef247b0fdb99e1",
        "darwin_amd64" => "708728e99b590d544babbde1c9b1de3d25f197b0cc0ac82e1d4b53108bc20020",
        "linux_arm64"  => "f2a2aaa21e8e6621feb9d3b4f1cce5618fcb6381bbe7445d28bdcae1a3742190",
        "linux_amd64"  => "83eb12cdf132598d1cdd0545d463edee7034dd4889858e26a52f9dc45ed4a2c6",
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
