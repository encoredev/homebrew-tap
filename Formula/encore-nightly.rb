class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230818"
    checksums = {
        "darwin_arm64" => "5006092fde0c105db0bd48451b13f9a9648bd9d8a084e4aad0f57c59498561b0",
        "darwin_amd64" => "9636841d14a8582de9ec49f9ce247f9bc0a99a47df4e2c9aff34728a5d7d565c",
        "linux_arm64"  => "28616057903c7cd57be3db9b1670fe7b0472b90ac1b0ee8f289f9b03746efe7e",
        "linux_amd64"  => "1d94d8540b820b4a56c4603f73b31f5f668c1972190c7326dbbd6aae8895399a",
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
