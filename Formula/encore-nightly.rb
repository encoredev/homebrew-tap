class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.0-nightly.20240301"
    checksums = {
        "darwin_arm64" => "ee9a6d5b7e1ee62c44a9f22d1686aa826c92feb5b8ae58e71372ca7517b78bb7",
        "darwin_amd64" => "cd0ef787cdea6ab6029cacab843680b888d5ba95e26892697dbefbcac0d6f7f3",
        "linux_arm64"  => "5af15b894b3b1855c137de9cd61720ff2e9f8c409b1e60b47c0a8bcf4581b6d5",
        "linux_amd64"  => "01dfc7e8060d6a5389a1e570a22920ec4f130042048aac9a46cddc1f4a39196a",
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

        bin.install_symlink libexec/"bin/encore-nightly"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "bash")
        (bash_completion/"encore-nightly").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "zsh")
        (zsh_completion/"_encore-nightly").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "fish")
        (fish_completion/"encore-nightly.fish").write output
    end

    test do
        system "#{bin}/encore-nightly", "check"
    end
end
