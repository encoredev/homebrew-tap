class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230612"
    checksums = {
        "darwin_arm64" => "351537de44dbd06ec5887c62686b33ead4edc4e9375a54254aced5b80b416f19",
        "darwin_amd64" => "2533156765dfb7d481b80c70c8affec8cd242695684cde93753d04604fb97327",
        "linux_arm64"  => "c4c8e99680e55d8cd5cfe43ae2293bc55730e59d2068a933044c3fe7e7969179",
        "linux_amd64"  => "8fabbdda872a683e4c95011b8226f2bf5d7d4a527c05a8aa1f6de997ac795da2",
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
