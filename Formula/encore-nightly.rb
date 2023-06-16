class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230616"
    checksums = {
        "darwin_arm64" => "a1eb644e6ec8135da325dd7dd95d0de9f5caac4dec9f2612827b45a6e4963ce0",
        "darwin_amd64" => "2d0b89b38ad043d57dc14f8129831fe802f98e8a5a9f12e0f01b5ff7e06ecc4d",
        "linux_arm64"  => "b24b39fe05928b49fb48b349ea97534c414ef41d68b846cb40c3b96fa824ec24",
        "linux_amd64"  => "6ed3c46ed9d20a959fcdb25e66585cd1a6ee792be7d5f8451347c80699eade78",
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
