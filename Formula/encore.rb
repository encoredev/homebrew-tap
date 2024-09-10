class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.1"
    checksums = {
        "darwin_arm64" => "d6e1e4c239218cc2af74a1f7e6d3a61eac6c65076c70cf5b004db286a0923139",
        "darwin_amd64" => "7b70fc867bfb6a6da1c11ed41019dc6619ce11da648984874d8843ebddf46199",
        "linux_arm64"  => "c7ff5b4e247c30f33535289a071bc3f7791e822e9475ba0f6245e852a9576159",
        "linux_amd64"  => "0f4da7e17660ff6eec6266ee426db6d6d0a10608960e3b3c0c08ee0b89182b40",
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
