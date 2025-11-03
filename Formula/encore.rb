class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.51.2"
    checksums = {
        "darwin_arm64" => "b20842710dada08ebdabc3f60adb0a4d2d4f7df54b2468d1d24b444d7b51ac6e",
        "darwin_amd64" => "e55fe71b5ec6f2f7a37c22e851b59e1251c1a1e4514495572ee141f520600981",
        "linux_arm64"  => "bf861eb4302fa2a167b6710cf8d8cb42eab689b74bccf5bf80e5c92fe82e8d98",
        "linux_amd64"  => "838d6fa02db960ec716da4127785542aec2119b47e2907cc9ea1199d6ef87739",
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
