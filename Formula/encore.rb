class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.57.1"
    checksums = {
        "darwin_arm64" => "22a1e7a93a49e6e94278bcea1f8c0a6466dede22c153b4e38862387039e4a10f",
        "darwin_amd64" => "43ae2f9d47497d20972e8eaec31d8032f065cf98b1bc9731cc41c6fe316d5599",
        "linux_arm64"  => "477cbaf596e7333744dcb3efcc232883dcaee02e3a0fa4aedc5342ec563477c4",
        "linux_amd64"  => "48b3b495fc23663fadc7c73ddefbcb4ca6dd5d0a1141ccc1124f12309c78b331",
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
