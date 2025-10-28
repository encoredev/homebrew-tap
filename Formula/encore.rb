class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.50.7"
    checksums = {
        "darwin_arm64" => "771fb6ef00f853795efaf8221b5738d85aa52fb760407173b50aacb3da6c26ad",
        "darwin_amd64" => "29be1e0ff19804f2d7c397d37d574f991e4333c0ead77850037696bf6c585bf7",
        "linux_arm64"  => "fbc62d520513892f156543c33a0a2d0d344afe1eb882a760e6046873754f0ef4",
        "linux_amd64"  => "eddf90e5a5c5375ea1b58584d6efb8046d71d460e2594815f71b797a79652db1",
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
