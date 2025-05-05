class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.21"
    checksums = {
        "darwin_arm64" => "5fb7cfe3722824d9e3de45cfb4a94de2a0d59492f9da992b67a2383ac335818a",
        "darwin_amd64" => "2e12eb359781a2f6eae167c6b06c713ae3841bdff0a43190669dbea4d679c749",
        "linux_arm64"  => "ecea2be6edb956aaaa5bf6384226ba49888a2b7046ad766ab5fb9584c6b04cd5",
        "linux_amd64"  => "2b68506d8001768820d2f4c98512b76084782790275c1f5b34106f9daed1672c",
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
