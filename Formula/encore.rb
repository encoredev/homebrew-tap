class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.38.2"
    checksums = {
        "darwin_arm64" => "22457c97cd3f130064e7766778688d53a27f9b75d842e907314bbfbd55921016",
        "darwin_amd64" => "0e233d1ceb13a2fe856a576e017884daa0433cf6b67146be08dda4cea60f1cd3",
        "linux_arm64"  => "35f9633b86f86ff6763295ad721ed54e8a850444a562dfae046156d6e6860e94",
        "linux_amd64"  => "f5a60e6c3890ea512188810e2e1e764e819fc9526d0a6ff1d2692d1e213f6345",
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
