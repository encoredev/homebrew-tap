class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.47.0"
    checksums = {
        "darwin_arm64" => "89a247359e4080df87345c32b35bd0cf1295f42a4888419e67582dde9024c802",
        "darwin_amd64" => "8efdb95b1fd34f889172bbd0fa70a30c61413be31606438a4f2a827be223b1b9",
        "linux_arm64"  => "c8d83b8b4f5c5e2a9ed9b51c31de10f74037a0abefbd9ac59542bdadc942a0d0",
        "linux_amd64"  => "ec6b6014aecc3d52852fb4d61e37b3c6e048bbf60135ec1823af5803949a1d00",
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
