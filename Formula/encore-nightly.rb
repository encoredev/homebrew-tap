class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230811"
    checksums = {
        "darwin_arm64" => "0288f535086420933475a4b16b4bf3424c44e65dbf3f1e62861ab8f813ce693b",
        "darwin_amd64" => "9ee5bcdd24d7e842bc74aece8abddcbbabea959c796404ba24653798ea92b251",
        "linux_arm64"  => "9e8803258d1fb9654c0f143d30efbec8957cce0f7697e67079bb4d6004c69384",
        "linux_amd64"  => "4b1666dbe1f1eca77260be34f7d688532dc92e203a242f4cd760591e1dee59fe",
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
