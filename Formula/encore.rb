class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.19"
    checksums = {
        "darwin_arm64" => "4020596aa79cf8b5d5d75be364f4b67e32134789902fd1b9dcfcc1b7d5775c7a",
        "darwin_amd64" => "baf3fcea9aec12f7aea06b682e2f90b34c7bee8b342907594be2f02edfa0ccc7",
        "linux_arm64"  => "62d29a9bd4396835f3aefe1c08b13d7448f2d15787a72db51875d21a16bf57d3",
        "linux_amd64"  => "000f6bd1be9ecc40856a6e4686c4d11c80f61d4c76538abd136c51954003705d",
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
