class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221029"
    checksums = {
        "darwin_arm64" => "d72ad77a3ae91a60dc7c78b327072ddbb75137adc0ebff056089dde762bfe6b3",
        "darwin_amd64" => "7472cbebfd06ff3d1e1a2e0d59b1a524e889b2ebb04a5e7c634889dcf0c51779",
        "linux_arm64"  => "54e8bf44e82332101e9697dc0602547f7b217cae341d8691475b0698ecf7c655",
        "linux_amd64"  => "324478c28fdc75325af66480113f85c1a38dfcd68b2eef826321b1bc905f3c9d",
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
