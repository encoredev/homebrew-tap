class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.38.5"
    checksums = {
        "darwin_arm64" => "bd3c2a3ba54cb1a6e5a3de38713eae764238dc595dd76c0be6fb7d534db4f187",
        "darwin_amd64" => "15eb7f11dc2d187a2238b0b313b3986c7cf871f4b6643c089d4c582d85399627",
        "linux_arm64"  => "81b4688e31678a42a0399de9c6427cba54c33eb07c9702780fe3fd7dfa1212da",
        "linux_amd64"  => "bfbd3de439a574e9b15e33e815652e102958e1eac7a40ef645d9b0326ce7db8a",
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
