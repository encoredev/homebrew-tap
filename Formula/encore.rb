class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.23.3"
    checksums = {
        "darwin_arm64" => "08031892490d3efe75c8c6facfd29761762c017d07a00cd1f705335cc5f610bb",
        "darwin_amd64" => "7fd021eca9d4dadc85f3207e9632e4ac48b77d0ed7aec1857b773b9f3798109f",
        "linux_arm64"  => "753ff95ee29c0c0dae40d903266e2c317f197b168fbe5b83e9ebb9ace8fbd5aa",
        "linux_amd64"  => "9a286f125099c3f47cdec38793050d1c63a81f5008282ecb8f428c7db2ae4f84",
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
