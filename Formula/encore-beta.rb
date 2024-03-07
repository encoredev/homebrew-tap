class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.2-beta.8"
    checksums = {
        "darwin_arm64" => "b27cb17206d08d51a7ac0469846d154f901e0e377444ca7be08b7e56854d8efd",
        "darwin_amd64" => "4c5c2884fdaf69daa0e873a8e7a444e5d92659865281ddf7092d9f28a71ec376",
        "linux_arm64"  => "11e90649f439d3a863722623828c5eebe13947df2db340ef2386d2391c485df3",
        "linux_amd64"  => "827cdf9e9e2ee4a979d0d0dfae44ae757868abd57a477a9bb6fd41a19d7a4e7a",
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
