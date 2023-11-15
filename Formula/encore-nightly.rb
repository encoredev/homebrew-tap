class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231115"
    checksums = {
        "darwin_arm64" => "e8efa36abcd84e5d6f0185faa913f11c9d7886481028e374eb2eba0aefa8b3e8",
        "darwin_amd64" => "c1319c0f0f352d76262d0a210de37529d5cc16987ea08ae754c00ca778f5c14b",
        "linux_arm64"  => "271187b321a6c3e7c3eafaf053f301d23f528969bcf04fdacde9ac01624f4f87",
        "linux_amd64"  => "d4748efc5c0af90de0891f602610d579157b37aa0df6f1047f3d882bebb22fd4",
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
