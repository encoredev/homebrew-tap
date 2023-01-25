class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.13.1"
    checksums = {
        "darwin_arm64" => "2416d4c73d3177854725bb6f6f4e694263999144c5830def2dbd172d78793542",
        "darwin_amd64" => "47473c23216303c2dab8c54d9616531307efc5e0e37dea88aee4943055ea6149",
        "linux_arm64"  => "26cc1ce84a400bc9dfbf36e3beb844cd5ceb3e2cd3092ab15e19278fa61d6b22",
        "linux_amd64"  => "976780575753620db3060059ea5ae09429cf2d7b42b53f79653b2a430f4fae57",
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
