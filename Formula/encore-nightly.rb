class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230812"
    checksums = {
        "darwin_arm64" => "a360b895ed4137d1e1d6db03739dad261789402246790c6c958c1cd550ced7a9",
        "darwin_amd64" => "c8ffb8095804ecb15b4c535efa57838bcdf1904bc2a71a14d63b412d0e15ee24",
        "linux_arm64"  => "240c2608af3a9bf99d1f7e265db87e13e50d4ba869d014a57d6ecee33a701435",
        "linux_amd64"  => "5b4a7926e8c08dd0a1b76ab263b17b8389cc44035a9b027dfd59794f1742d134",
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
