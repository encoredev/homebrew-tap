class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230318"
    checksums = {
        "darwin_arm64" => "60146b4a1114f9906902907c8aab8bb0219efc014d4f2879b651aaa390adebf1",
        "darwin_amd64" => "3fcc74e44c746c43b14e69eceb161b08caf97444f846afd820938374f0e95125",
        "linux_arm64"  => "8f3a009dc194335934d2c9b8c0bbae6f86d5cf65e61bb8376b0516f1e815955d",
        "linux_amd64"  => "0d419c7ae3fee938b706806e3d7de6a9bbbc1a53f6a93c1822f942bd2c01585b",
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
