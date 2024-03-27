class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.5"
    checksums = {
        "darwin_arm64" => "e8915ea006fa478183dd8f8ef038d6f74347561d95777d63a403da67b67fd80c",
        "darwin_amd64" => "061ed868cd9dd4e22d37e0b2f8746a5f39e6c33c20e89f30ffd776e74b8a966b",
        "linux_arm64"  => "6676ff89e9adb11bf4c23c6e505a3f92666d86d6eaa95649f253e4eda2d2c2ee",
        "linux_amd64"  => "77de68cba5fbac351b2a1d9fb611f7e6e052ce06225a0e04b3c29c046e40bed0",
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
