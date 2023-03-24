class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230324"
    checksums = {
        "darwin_arm64" => "0fece9c1d46220f7afae58edf49e00bb6fb2f668e7f6868e56c005930a052c6d",
        "darwin_amd64" => "8abefbe0c26362485fb1f13bef59cd31af2a442a80a064ad073fb14de23a7af3",
        "linux_arm64"  => "87bcad33c3a8cccefc48dc91fc66f2a9d7d40f18f43ae1d02e5ef01d3c60abf8",
        "linux_amd64"  => "aab43b1823bf2e821ea3c67e65740dbe328696c99f493b4e92480baaf2ffd63e",
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
