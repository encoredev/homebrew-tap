class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.14"
    checksums = {
        "darwin_arm64" => "8338520f00daadc62b56e38c990325ad0b9513c342bb732a1ed2dc6e94b858df",
        "darwin_amd64" => "8389def8ed3948a968c817fc2c0db46fd32642a1e621e6d8a2eb3308c01eb6ec",
        "linux_arm64"  => "5ee62d387dec6772e39e4434ec3c58c162736a97703a82e95f11ef574b9d54f6",
        "linux_amd64"  => "c5674b540d7272faba3cbe4d71c11dddadc261b0d0eb0cffb384fc49fa88153f",
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
