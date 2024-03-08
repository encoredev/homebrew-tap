class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.33.5"
    checksums = {
        "darwin_arm64" => "e52039bcc360f5ff39e9393cd9ba204e25edc8aa09288422c6ea74f8444657b3",
        "darwin_amd64" => "fb7d9f0e16c5b1c2ccf0206173ca2874c6d4d1839118144d570d65f850b3c91a",
        "linux_arm64"  => "a621449db2fdd841514bcf310fd8b7f4f58681807ecd69d465bbdb06266393ef",
        "linux_amd64"  => "82be00db8091e7819fa9f94aaf7e8cfb758b6ff2c08a7b03c691813161a7c804",
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
