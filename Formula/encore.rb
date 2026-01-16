class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.53.6"
    checksums = {
        "darwin_arm64" => "d8e7c72f91518d07d786317d88b96caadec1fffb39625d93c8f95b1b421fc5d3",
        "darwin_amd64" => "401f0161df44804554aafbe4b16008347c998d2910509f7f68d99a85f1c97968",
        "linux_arm64"  => "b847ef65907d347e04deba701a8996cea8c2bc0cccb0d25e93dbdde0bda8ef80",
        "linux_amd64"  => "1222a917a0664bd16fcf00474f7f48b211af267c71eee25e33e8d3aab3871bd8",
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
