class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.2"
    checksums = {
        "darwin_arm64" => "71a9d80447c26d63d62c61f04c51cdc84ddee5d453bc8851aa7ab24ed2bc12f0",
        "darwin_amd64" => "87b43cbc82f80ecc6ecd7aebc9f8ab88a60ac22b226b62521063f3bdd5da7aa6",
        "linux_arm64"  => "103da6270e94ed45f71dc40b5e91b0996f5cc33797d0ba0fc83abdc7738e72f7",
        "linux_amd64"  => "eb977d9a83e6f6f7c6f9dd2e09bc30329cab46ab5fe1c4532f2bcae72bad7195",
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
