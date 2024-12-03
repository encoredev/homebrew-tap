class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.9-beta.1"
    checksums = {
        "darwin_arm64" => "d80374825d6476386bc49ec7d065b07b9076bbae9fa67822c1053de134d7158d",
        "darwin_amd64" => "f748388f8b8a6aab68103503950ea762193cae5b5c861b4e9dd98a3b6e20e8a2",
        "linux_arm64"  => "2584c770a32e47bf6cec91ebf3a4d6d5f2c85dde61cc8f4133ab586666a3ac92",
        "linux_amd64"  => "f88432b2e891d70a64da3185c30f9a18f6721fda74507f29dbad776d9a01f49e",
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
