class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.33.1"
    checksums = {
        "darwin_arm64" => "703a39e8506e5e09c63fad764f6eb49ae58e4e1bd903ab4ce2d8739bb201bae9",
        "darwin_amd64" => "47b227bdb17a5fc6407b397ac2fde5ee335bec6efdf2ecafe93787a045557d4d",
        "linux_arm64"  => "5a9969d56c5b0b830284af60be315bb22d156e2529b5b7d88d68deaff182b624",
        "linux_amd64"  => "f51a87d007a1dc8c6017d11cb0400a1c8bb34214891bd3c501cee9d400dd1b82",
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
