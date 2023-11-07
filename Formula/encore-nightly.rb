class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231107"
    checksums = {
        "darwin_arm64" => "4b7d45998a953e99ba25c9c4839e8be4c7f60cecfc33159ff78ef53336f1d9f8",
        "darwin_amd64" => "df5ef7d0faa110ddd4fd878ea8a3b55ce8fa0688e3db1e1312b1c1e05c3d5cd8",
        "linux_arm64"  => "79796e4c09b48428c84066788a92b040c964bcfd25f34c797598bab0b36cc013",
        "linux_amd64"  => "20bd7d41c81e9c5ad4e4cb952abacf24ff80943d53f74e1ba1f1ef136c4f3f79",
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
