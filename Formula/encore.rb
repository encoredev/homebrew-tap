class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.57.9"
    checksums = {
        "darwin_arm64" => "39329817818e057fdccb47b802047909e23bcac24ebceb8efd7cf18c84fe91ea",
        "darwin_amd64" => "0261cf0d4e95027ad0c4381ef25646fd080970a3b08b8a4564059c7801739e10",
        "linux_arm64"  => "e868ee2d81a39631ccd29e4f2e789c6bf8b40f028d462a00505ae590c7a728d2",
        "linux_amd64"  => "dfd43dcd456f91414a823315480da921333e6d1e3535ab48c47c09225d022af5",
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
