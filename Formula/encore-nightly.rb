class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231003"
    checksums = {
        "darwin_arm64" => "bd5709f62d33ac8341a1c9292a29bf29b3653926f1f2087f38983ba11e76d137",
        "darwin_amd64" => "e1317cf735453f26d42fb9bf29e9ba03108ca8091878633cee9446f0aa44f87b",
        "linux_arm64"  => "ba11f6fc61e9693ffeafc16a5729a5d3aefdb0ff78051d38d565a7f0a515bb21",
        "linux_amd64"  => "ee4e2ab77ebf7633cdcb06ccfe3140ae86a25db93c746cbbbddef4477d0efdf2",
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
