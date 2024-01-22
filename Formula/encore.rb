class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.30.0"
    checksums = {
        "darwin_arm64" => "2555184c4fdf1103d1dfd7ee398fa00b9a33dfbf72fc559628510a0cfe5218f4",
        "darwin_amd64" => "84a2585d3d3b9b9971ff3b554d99b30a7f50b6127ba322e4e710cc6fea2de515",
        "linux_arm64"  => "10b4492ff3aaf5502f7d0a74fd23d0d5592d8181753eee5d64eca8a13069145e",
        "linux_amd64"  => "5534c49529f8ee6ad8f331d1ce67513759970afda0c2d156ca6c025cc713754d",
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
