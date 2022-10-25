class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221025"
    checksums = {
        "darwin_arm64" => "8eec26a36ef5e66cc3849c196fde3d3dcd065f50413ffc44e5df3f285b82d8b0",
        "darwin_amd64" => "73ef2a466d55a8395e3c144b310c31ed9458fe84a028d293ebb952aa24f7dd1c",
        "linux_arm64"  => "a58e081dc943b2facd93cc8bc44479bb668cd991a7100ab8021008804eb07bb5",
        "linux_amd64"  => "ff2476def3017fadd35d44d4188b995eedadef85f0a344ca4a9afcb1adc33dd3",
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
