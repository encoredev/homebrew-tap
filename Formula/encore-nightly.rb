class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230129"
    checksums = {
        "darwin_arm64" => "572d02935bbc80d7e6ba407100410aac068466e81d131b5f749fb32a82fc1388",
        "darwin_amd64" => "972a08c90c5a67c76db96b518846cffb19f9803b16ebb86271c40f67bd4a6c89",
        "linux_arm64"  => "af7a4f508f4d89c294467ea52023123def1e984287aad2ac62489334884bc486",
        "linux_amd64"  => "8addbe26a94ebaf046f8401af2c5e1edbf99a2727ab6b64c70f6b645baf5ec1f",
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
