class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.33.6"
    checksums = {
        "darwin_arm64" => "8e78ae17d4194d1e9b896ca7b83df933140516fccee9337046426c0a8f0cd517",
        "darwin_amd64" => "4b3cb3c994a9b3ae28b15cbdc9ee304c68d1d0149835902354645fd217736d92",
        "linux_arm64"  => "9a3f141817e4cadcf87aa88e43906267f7d9bdf4a78ed6782b02da6977d23d09",
        "linux_amd64"  => "454edbb5de852eac035489c00e43c4f6f7dd0b6286edbc63a915f428bad25737",
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
