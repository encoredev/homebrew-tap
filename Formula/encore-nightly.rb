class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230417"
    checksums = {
        "darwin_arm64" => "aee5e69edf7ac91b5cd885b331be1530b5f31791a6c0a72db875c08501d3e2bc",
        "darwin_amd64" => "650216b9b4398d9d8b8d825beb049b166822f3f741a1e3d3dce701bba32a7059",
        "linux_arm64"  => "164b6b96a6dcf16c4ac8a3fa4a4874a6b6b24fcc3f12194c968ccb2d5bb98e41",
        "linux_amd64"  => "519163129fd7b370295d563fff288863f6f38978565d1b65a40c580036802506",
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
