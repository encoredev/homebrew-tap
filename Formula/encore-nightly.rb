class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221104"
    checksums = {
        "darwin_arm64" => "fdbd939d23b8676b82ec0fbdb5a62f2c1a48f244707408be9cc607c75d2a0538",
        "darwin_amd64" => "76332d909dacdb99583c749d47766f6b507acc755ee1635271a614a5329fd4bc",
        "linux_arm64"  => "8e07ea663d019343a57fa63258b0c82ec3a26eaf9d387ffed9b200d5babc00fe",
        "linux_amd64"  => "ab62f68495b62fef63a64c9c9305f69ff5e794a8bb28598a2d74f19ae8d027e7",
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
