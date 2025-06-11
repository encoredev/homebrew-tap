class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.4"
    checksums = {
        "darwin_arm64" => "ebe39a3d1fca6b508dcb5360f9dc6fb031a154054ae224bde4b7ae881730a6de",
        "darwin_amd64" => "ba5c313ef31b136abac7e2fcf2eef799b85f2b2c055763cbbd38f9bb7c6f6411",
        "linux_arm64"  => "12db5aa6eb3ef284a7a3c8ff43b764442dbc5274f236977face80841db6bdbcf",
        "linux_amd64"  => "6bfd79ee44580ef5b1fd6e7b273039eab0330d9ff4ce0118416ed5104bbfa17c",
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
