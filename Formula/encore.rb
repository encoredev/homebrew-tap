class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.10.4"
    checksums = {
        "darwin_arm64" => "55d17dd20112971774da722af8777e7c2932d3ad67f475b0a300b5c1be4c9bff",
        "darwin_amd64" => "45e4880743deb68040955ee5efd206441496cbb6f8865a7fcbcbac3c194a1a95",
        "linux_arm64"  => "21a903038504ea80b08275460088b8ef0085a900fb9e0fde1d98ca42c3e98f2a",
        "linux_amd64"  => "c5f1e36983958b9f8cb0893f7dfbdbad2fca6e3f9e808dfb486e1ac5ea16fea2",
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
