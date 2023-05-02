class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230502"
    checksums = {
        "darwin_arm64" => "6394bfed0bc6ff79caaa7cb15f1a262221d4f006aae9c7d216e6f159ecd5f615",
        "darwin_amd64" => "d8eeef15ba0b6a476be30a8413dfb90fde6f14e1e36309c4434b65fdab21ecd8",
        "linux_arm64"  => "50423026a5d935e4ee9c48b7c7ca57a2173a2c2b5a2294552d0e54374be4c80c",
        "linux_amd64"  => "b15ddcedd18e8e8983e9efd35934ecb6a68712b3248fdd905ef03d1bfb13e74c",
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
