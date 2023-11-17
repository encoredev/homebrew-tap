class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-beta.7"
    checksums = {
        "darwin_arm64" => "b06d73d8438d038e4be7d892ca691cec3d0f8bc526f2ea7c38e3c033b01b3ea8",
        "darwin_amd64" => "c63a47d620d0abd9a202b625404c0ec21e796ae420241d416d91e887e7a6e37e",
        "linux_arm64"  => "9221496a3e4d45ca5879e95e741960b8f6f77407157d92d481f8864dd0c51e51",
        "linux_amd64"  => "0cfaaa94ef26fc15e9842f9215aee7ddd9d164090bf7c7c15881ebb1512f8c01",
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
