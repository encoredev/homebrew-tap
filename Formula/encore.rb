class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.2"
    checksums = {
        "darwin_arm64" => "4dd3f62c2714ffdb66b5840b69129c91edc2a05af06547f497e475e9e94bfd56",
        "darwin_amd64" => "200c4f8be2fe455fc2faeeced18549021d7888b047c8e30c4e97f0f4fad34f3a",
        "linux_arm64"  => "0bee9944e05f8efc0b6491aef47efe2357a130c39c6ab29bade0cef1b0bc7253",
        "linux_amd64"  => "2f5ab8fe365f1cc53e7697a9e0a98729588f6543de0e4f980c1d0f4bfcfb94d8",
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
