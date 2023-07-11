class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230711"
    checksums = {
        "darwin_arm64" => "bc0f690c99bcc5df25db2470dd21699b9cc79a559738aaf66ef84ba9b2fd9be1",
        "darwin_amd64" => "47e42b1ab8c0cac1b05293524983f657ff629871dcb3434760ae8fda2aaf0b57",
        "linux_arm64"  => "90787ceba78cb4204f0ad36d1ad4c6963717494faf664a58eef4993b9e4b3dd8",
        "linux_amd64"  => "816e2eecc97331bb729782a66ab77838382441aadea99fe5ac8bfaed3cda27df",
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
