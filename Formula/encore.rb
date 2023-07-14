class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.22.4"
    checksums = {
        "darwin_arm64" => "faad1a13c29cc394b6b74dfcdf0be1643edfc9673679618b29381f8797a11089",
        "darwin_amd64" => "7c74039710aa267c05354cae873a02ace6e7a6f141d0e207744c14fd5716b4a0",
        "linux_arm64"  => "92c5cc6a8d60c5495c8ab07d415525a19d7b1a21b2fb031dc6a3a132ee44838f",
        "linux_amd64"  => "ecde0bbc6038aef43e8f1cecfc55e523a3f76d58e76129c4787990b904e7b350",
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
