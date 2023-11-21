class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0"
    checksums = {
        "darwin_arm64" => "2eb53fc4865ca0f8057f95a3385159c1a5b8a39194a2fd72bc7e83c30b3ddf0d",
        "darwin_amd64" => "23b4cc5f334d4098ba54992fb8d04af794a33dd529a56e0295ca43108a848008",
        "linux_arm64"  => "4e933868537fb5d99ad743e97d64b7e9e32c6e00f6d15717b264245a3bd45d0d",
        "linux_amd64"  => "d53d88f5e3baf737f1105fd5f35867b7188b8871b9dfce27ab87e482783da1be",
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
