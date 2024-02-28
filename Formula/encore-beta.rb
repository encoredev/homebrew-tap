class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.31.2-beta.6"
    checksums = {
        "darwin_arm64" => "7390dbe6059de197b2a8491cba83d09623d17ca8476b8e3c586e6265d37b5706",
        "darwin_amd64" => "bdef7cb005468f9ffef918ad73baca7cabbc52b6780582fd3ca53b9321391a29",
        "linux_arm64"  => "760fed39226bc617297697d7b179613d93779536b492b6c9916f16ebc8e74c1c",
        "linux_amd64"  => "f8ae56f9bb75e7a0b603e05af896069c179c1beb327eb66395fa5497af091c0f",
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
