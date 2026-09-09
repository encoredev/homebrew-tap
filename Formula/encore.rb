class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.5"
    checksums = {
        "darwin_arm64" => "cb7273cd6be686cd364d4b29479ff7cd8f38fdfa9ceae05475aa238d10fb2aec",
        "darwin_amd64" => "52158af7904cde736190f65e27a51e056fc3db26be76e57b2ee39d98d6e7d121",
        "linux_arm64"  => "30c06f8dfdaf81b79af2ce3676f671f11872d77358ecee06effd6a459a561375",
        "linux_amd64"  => "d919f83b6866a7bdd409a0ebf399728840820a82940f87fec2598c99d7cd6295",
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
