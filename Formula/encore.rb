class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.22.3"
    checksums = {
        "darwin_arm64" => "89e6c08f0bd5d6a006b83ba52b960eb00b47cf66d0c8dff525030accb45662a4",
        "darwin_amd64" => "8649c12171170694508fc20fa085f7ed2875c8d4f0a3dd0c3fa601052bb4874a",
        "linux_arm64"  => "e4fbfed0ca019ade2adeb0f4ebe5688d844b809147a4ab7e7f547d27e380bb0d",
        "linux_amd64"  => "68598c14de58c8298e36dbe3d49aaae611bb1b6f71a185edde07195975b607aa",
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
