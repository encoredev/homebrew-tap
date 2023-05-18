class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230518"
    checksums = {
        "darwin_arm64" => "0b1015aa7a76acf109ee77ff40c438e60e4f985090cd576aba2c0c1fdc2b339b",
        "darwin_amd64" => "a921db06721e64871ccfbab30a49a5b922cab225e612cce3ceffac37872a55bb",
        "linux_arm64"  => "47fc60042fbf5fdc50cba1bd45d2146f8a8485871c6658230dc0dfba4ee0e7ae",
        "linux_amd64"  => "66844ebd5880bdda41d1d0628e40564c04d5bc22e569437a10bedf07a9319508",
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
