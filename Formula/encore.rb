class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.6"
    checksums = {
        "darwin_arm64" => "95dd623a107c1c9498c1f66ba80d82e6ed0989ebf01360feae719c641a7a44c2",
        "darwin_amd64" => "75ddf8aee2a11485d1af99541640af9a622498f6e06778b21bd070ab7c58b8d4",
        "linux_arm64"  => "d224739cc6207144ac3a25aeeab2ace763dfafbfc4f3feec46f9e76fbc07002a",
        "linux_amd64"  => "1ffbb3f65d64e02e3d34530e3d065ed16a4bc030642712b0ea163ffa73018132",
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
