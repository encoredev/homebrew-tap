class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.20.5"
    checksums = {
        "darwin_arm64" => "3ec1be2c6988769d752949115c41a66311e88bae332ae4eeecbd6286e594f569",
        "darwin_amd64" => "3a717ee42558469134ccf6260c937946ad1bf1a58414d5e9c821c80f632ea1d4",
        "linux_arm64"  => "ef3dbe4067c284dee23fba41c90b690be8e11f0efbf17d092d1f0ad613e755b4",
        "linux_amd64"  => "0d5c9d7398e9bc43f63387a5411770cee2943008be91af37ed9ee4824a651aac",
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
