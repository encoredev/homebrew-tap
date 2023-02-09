class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230209"
    checksums = {
        "darwin_arm64" => "05a9f5d0236d072c2ce8b11888cd964d39b86e3b27ddb26a06c508cd2d249638",
        "darwin_amd64" => "14ac3eb104647e0a6623c7541b8125394f12be7e12274f644ee8e493f053b9aa",
        "linux_arm64"  => "e8e56c00f0e14bbf30a524a7eab1a9fa10e113c56fe1583855bcee8fdc35368d",
        "linux_amd64"  => "c6ab6c967d1d6ab0e3eaacfa1444ecb670fe5c27b5174336164fea6ad2a1d7ab",
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
