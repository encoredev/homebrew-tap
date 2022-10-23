class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221023"
    checksums = {
        "darwin_arm64" => "9a841a27c13eca54dd321d7a299a8d5c31eed3b864381cd4fa5259688db24231",
        "darwin_amd64" => "069ddaab40f8c15a3dcea48ad2651c7ba10fcadaebb2167740f733c168590185",
        "linux_arm64"  => "a6b19a6e22b1b05518464f6b0f20800c983a9d243149f80d68b8b9a4d118f346",
        "linux_amd64"  => "b680022e44af24ccbc6be49d27471876d524c7f432bbbc2fdae750d09b698345",
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
