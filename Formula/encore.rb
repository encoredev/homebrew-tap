class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.57.11"
    checksums = {
        "darwin_arm64" => "90839ca15536454472c726a043c870636ef95f1260d82e43d9eef215a45132c0",
        "darwin_amd64" => "891cfffd5274db9f0f7f647b5d27606f5914d4bcfd6ca25b3bf134194ce2c1ea",
        "linux_arm64"  => "2b53916d92b3840e61f1b9cdad4006120a1bf72f56aed23f41553ff28d89ef91",
        "linux_amd64"  => "df45a52706a8d46b297f46a8f1f8434516c6445754710b392f764d68d1bb226a",
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
