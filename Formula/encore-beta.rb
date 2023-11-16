class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-beta.3"
    checksums = {
        "darwin_arm64" => "b7564ae7413fd015fab80f62ca66d6f7d421d90cf54f83a8b9227b318ed47c13",
        "darwin_amd64" => "30af01272514f706556441381ccf44039ede32800bd346cf342e89d3e5cb1cf7",
        "linux_arm64"  => "949b9caabb564e4cd7f57bc508915ded5ccb9347a2ea8d215587a8a20616e31b",
        "linux_amd64"  => "abf651a87f107a01a0d39f79745498bcd4ad95dcd266f247044156e7af9041f8",
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
