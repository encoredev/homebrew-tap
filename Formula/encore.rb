class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.11.0"
    checksums = {
        "darwin_arm64" => "953a87392405c29d9ed08c6b6d07e6ad3729deb18f65b2107b5b6d4652d35838",
        "darwin_amd64" => "bed5e627924042c3aba0e91631d4265c053ab5772cac9776b606ef5a9d794f9b",
        "linux_arm64"  => "a2532b98b0ef326367cdaa8686bb12a115e05dc9c5b60869ce5b2c70ab1596a0",
        "linux_amd64"  => "839db4775ebe97b2fd00a4d257704119730a29a2dd66369334dfc0a63a9aca2c",
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
