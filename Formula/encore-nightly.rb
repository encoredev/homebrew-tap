class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230822"
    checksums = {
        "darwin_arm64" => "5fafbe07aaa69a5c596276db0ab92a3f75fc05d68a7034185d80f97fcb4ab410",
        "darwin_amd64" => "39969603c0d2cb3710c51417e7fad607f0e0e8aecfa3112a00320abbb61028e5",
        "linux_arm64"  => "ba41c6c0395b403bd5ec2b2934488d62769c0e6d21dc67efefc9587b194b86e8",
        "linux_amd64"  => "d62a21940f685e5e0bcc09d50eeeb37195f519a2a44bdcd77d10460b4cafd65e",
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
