class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230930"
    checksums = {
        "darwin_arm64" => "cccbfc84a7dc0b2cb0a1f0138857262cd5ab4aca00e96bf594ca7e5cfe739adb",
        "darwin_amd64" => "97bc12810116127ece332484bbfc35e148ea64b17442ddcc8ed10eaba588ae17",
        "linux_arm64"  => "59d26974f215fb6bfcce0aa5af5dc5ac30201dca5ce01a1bc1302b20ea728ff2",
        "linux_amd64"  => "0b77fab1e001ba8c463baa98e5170031da3756af081a3933dea19e5215a5aa40",
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
