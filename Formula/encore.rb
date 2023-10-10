class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.27.1"
    checksums = {
        "darwin_arm64" => "88d04793b7556eab94c871213ada6863d355a0ca4386f2bd4b4338be52bc5382",
        "darwin_amd64" => "493f5f1e1229bf8e88ecdbd5cb3f8aac3af5d67abf5a20d8da1c31f42deae5f3",
        "linux_arm64"  => "b4bde123c90c0225cfed43ec3913bff129e3628ead877301597f5b28d97e5010",
        "linux_amd64"  => "cf14054653519d1db84966aff4e61c71437514c8806588ff0413f04d4263f329",
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
