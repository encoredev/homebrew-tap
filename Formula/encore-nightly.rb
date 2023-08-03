class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230803"
    checksums = {
        "darwin_arm64" => "4f3c160f66f76a16cafd0410bdaec27312219913d999f19618671b0a0721c669",
        "darwin_amd64" => "2fd0dfe79d289cafbead578564d91cc071e3c90322f4cf612b92d1d1949be8e9",
        "linux_arm64"  => "560914dabac8f3ce932c4277cfacead787e133b04ac9214efe56f8ad082fe5e0",
        "linux_amd64"  => "3cd59912065f0611a23dc3bf85850737643cde1ce6ff6e8a30c0adb389d2568f",
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
