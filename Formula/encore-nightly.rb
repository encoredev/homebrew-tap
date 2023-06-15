class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230615"
    checksums = {
        "darwin_arm64" => "cbb14812289e8cf7e7b7aabd361f099f18b2e1155a4ec50a5733903d3df89cbb",
        "darwin_amd64" => "93ea9ff30548b313bc026e72a65f25f283c527b8ac733ef0ad7cd47e2ecebc1a",
        "linux_arm64"  => "911272306cef42729aaa11aeb7d19cdd9e25fc4096a9b68763e41f9e72188234",
        "linux_amd64"  => "5261635a948835bbbd3d2159809f72bef5a11da409adb2088da2aa017db32c8e",
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
