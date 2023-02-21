class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230221"
    checksums = {
        "darwin_arm64" => "057363c6ccd7477f3e6f787d448392b4eb2f4cde72f3635aa8166fbc014b90b2",
        "darwin_amd64" => "72e39a952774853c162ad6aef0228fdb1c175bd2ff0b5d70f6470c93aba4f04a",
        "linux_arm64"  => "86a69c582d3ac425907b0dc5ce5ca349b6c472d98f7759954b56ad258e92dc64",
        "linux_amd64"  => "ffd014780af2f16c32b7c54a6a60fba112754a401f69ab1e2c3049574b37efe0",
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
