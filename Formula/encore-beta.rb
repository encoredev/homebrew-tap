class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-beta.6"
    checksums = {
        "darwin_arm64" => "5c752f312dcb952636f6f1a8cb29bf3a3082c07f8d67c64179e0f8bc6d77101b",
        "darwin_amd64" => "49e3928c19c3164a1b70ebc7800182815ddda57c29700793c80db5fbf66ccbf3",
        "linux_arm64"  => "170a83f563cdc36f75d128468d855231388b300faeac37cf991c9ad664ca38fc",
        "linux_amd64"  => "36b52d55586b6c5f0e74dd05d4fcb32accf1fd7cb4895b2ac9cfb74dff0ae6c5",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
