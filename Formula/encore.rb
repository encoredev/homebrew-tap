class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.31.1"
    checksums = {
        "darwin_arm64" => "abca608b2f0ded628c7ee2c8d1a31acb2086edf1178571cdac6053b31c3dbf2f",
        "darwin_amd64" => "d2bfc1b68c3760aae7e0007088077d4d0de5800805a68abb850ccb9d7b833fa4",
        "linux_arm64"  => "5db70c91cb6f3f24013f5466aebebd50adb91f91a437380bc1e4e77c4149f366",
        "linux_amd64"  => "35150a48c86aede568502639ee6fd713bcd24352aaa48073e03648596835be46",
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
