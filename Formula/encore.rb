class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.22.0"
    checksums = {
        "darwin_arm64" => "d8d2c00ab32ba4891568676278777ba7a1696043160d7a351ea1e3f7f16020f1",
        "darwin_amd64" => "de48acb1790720cce4667d16540427758feb915fec4e5afe8befd739fd1543f6",
        "linux_arm64"  => "378b38bf184ea3149c41d97a186cf165bd6567911f18b77e8457dbdc4584f72c",
        "linux_amd64"  => "b75b7f7f42e72323d82ddd764996070169b52bf6d0a91f90c54af29a19bdb8a3",
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
