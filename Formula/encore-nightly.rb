class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221111"
    checksums = {
        "darwin_arm64" => "f6fe18351252cb677074c54fdc98047461f4e4036305f5d249394c9be75b975a",
        "darwin_amd64" => "9ca39e93c0fb783e08ca026469414830bffcf00e7ee9d5ca37f9a5bef644591b",
        "linux_arm64"  => "d209806e524e790926d1e8d455dfdd3431670d710450a2dcaabef973a5638311",
        "linux_amd64"  => "fcc0c605f62ff06f0deb3c06670160a8a088b7d07094328fc3e903f667899eb1",
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
