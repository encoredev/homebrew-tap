class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230621"
    checksums = {
        "darwin_arm64" => "7dc754934c2cd863860b7db0b7d67d20728405c62658f113c1ac15e7bd72f240",
        "darwin_amd64" => "2ac3a4cef5ca34e4582a9cd3399a193c3809d66fc672e5a7f349a5b266b9460e",
        "linux_arm64"  => "dffb36341d5521c74ddf1c8535293a52574e0a602f530f027c42646f8ea9f8af",
        "linux_amd64"  => "26be3111962093b0db1a372ef235f937002cf57343ce9712fe69e0273ec22dcb",
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
