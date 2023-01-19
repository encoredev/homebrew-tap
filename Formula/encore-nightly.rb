class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230119"
    checksums = {
        "darwin_arm64" => "9e6d1586e1946d071a24c14f485620d10e6b1db573ba87229cc7e66922b89416",
        "darwin_amd64" => "7770e5dac3cae71b9d2bd7a2175e16e9bfab0cfbeb0b4f75ea508948afdbd068",
        "linux_arm64"  => "31856bb2158dcec517a3feca4b04864a744ab907b22dda53ce4939b0984d34aa",
        "linux_amd64"  => "eb7b9fb76cb2d6a260bcfcc2e964eaf5fbd805145df6fa1eea412728d4c6d73e",
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
