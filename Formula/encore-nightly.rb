class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230614"
    checksums = {
        "darwin_arm64" => "83c751195bc8fed80b56a554e22f46ed2addde2bc59da3a843bf24000e7a1823",
        "darwin_amd64" => "5f179d64a8b56f693af9561a1f58cb82793743426da60868fe30fde67a7c0bc2",
        "linux_arm64"  => "bb94a2b5821094fda223d3e24ed63af5cffb1651c9023dbba7e159267cb85645",
        "linux_amd64"  => "83998b4d035360e04534d0ef0a02dc48be60e9c8d981378519e355b618091a4d",
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
