class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221125"
    checksums = {
        "darwin_arm64" => "c9065fffe33e1c31835e3504977aa8bc13067205149934fb6fa91d1aeef2d039",
        "darwin_amd64" => "10467bc9badf9433c30b7975fd7d4a1c0498dccb05c96b7c69adf51552a41882",
        "linux_arm64"  => "003f606713a7eaa064ca95674825629748a78d6f39d4f8c61783163f3e8a304c",
        "linux_amd64"  => "e4224e27852895640bf9987a56173b69066854e41950b25b54d61c987f225d5a",
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
