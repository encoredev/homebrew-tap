class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231007"
    checksums = {
        "darwin_arm64" => "d23175577f4f4134130ba864a420d9336a5d1dc73384122badbe6bad8d0174c3",
        "darwin_amd64" => "d4b223183ee4b066e3c616959c6c08ef78ec0e642d70fc2bcb3485813c98d04e",
        "linux_arm64"  => "4ea34d5882b85db032c820e381178cbcc4be048e8eaaf4de821fc98e49473b07",
        "linux_amd64"  => "009c0c5cb99f18b5e82a72b9b456e4d817a748a429af949f36eb3f3f4e145db2",
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
