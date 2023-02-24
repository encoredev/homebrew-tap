class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230224"
    checksums = {
        "darwin_arm64" => "ce37f5094648507cb27bbbe63c30d861d5b280100e4c57b1ada91ef158f2aa6d",
        "darwin_amd64" => "496713eb5c41ffb63daa8714229d19fb21561ee96745701a992e1c0ab120a6b8",
        "linux_arm64"  => "169400db47526fe6a9c20f3ed5ee6df4b4ced285579ffae9b3709c0b80b3f814",
        "linux_amd64"  => "01f0321189fae412a694f7b79a4adf3ea912ab48a676d1101b886395aa4681d2",
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
