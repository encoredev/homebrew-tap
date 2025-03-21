class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.12"
    checksums = {
        "darwin_arm64" => "a7027da441d4fcddc370cc8218f3e47b3dc2bb58c7d442535ae948669b833c66",
        "darwin_amd64" => "25f76c631036e21a3dc066e5bcbbb5bed563ae1c4eb3111b5c6a7d9ef8069b88",
        "linux_arm64"  => "71f4c0f54219604fe574944bab98cff2d03e23de614a0036e914674d8042c3c5",
        "linux_amd64"  => "1351ed0b12caa1eba4cf5cea34b47e8c909bb17c87d0af7d4ccf2700d95a028b",
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
