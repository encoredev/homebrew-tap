class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.39.2"
    checksums = {
        "darwin_arm64" => "d8412889b355063aa5ad06b7dacaee2fe3d0fb4c28fb90e813f99876c2f467f4",
        "darwin_amd64" => "34a5c24aa20fe63487195f884c7e84cfc2f0c3eac0495d4fa83ef91d34114f27",
        "linux_arm64"  => "a2a340b6fac3bd340a8f7a544a77d025e7192a77bf657b0f1ebcb3cd4639f3fa",
        "linux_amd64"  => "3440dfacc922f4306476ce5d7769436e41513df9e2578a65e1857cfb146962c8",
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
