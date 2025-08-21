class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.49.0"
    checksums = {
        "darwin_arm64" => "f47443051a3ccfd59a4757bf1dd6e45b710310f29828e1ead1c6b30b5ce61589",
        "darwin_amd64" => "79777b493a2570144e9c578cae6fd3625659d7e319dfdb570d71e4100230a61c",
        "linux_arm64"  => "1dc5e63df4c2102bbf75e0190b3c0a72d97165f99e607da06cbadcb7d978d174",
        "linux_amd64"  => "1f8a292bd7db09e3ed23964bfd25ae2c935b888d7ce82faad9e19111ff539078",
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
