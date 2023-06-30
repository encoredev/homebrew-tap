class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.21.1"
    checksums = {
        "darwin_arm64" => "949e6277d27e8f0127320a7a624b0d03b2c33f44c3ad4de046b4f68b4b713512",
        "darwin_amd64" => "92fa55e76dfc892c35b9397e362521fd0710aff5c536c0ed5ab5f9ead62d283b",
        "linux_arm64"  => "fc216f8a66f3ba9ec9855bde5037402434bdba18efa1bcfedfd8ba6a5ed3ae62",
        "linux_amd64"  => "0445b23561a18a61f80d20c7936f73275645155ffad8d2619acef6c259354bb1",
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
