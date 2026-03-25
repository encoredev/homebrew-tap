class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.56.1"
    checksums = {
        "darwin_arm64" => "bd422eb95b68c4db512dec443080568d67cf00325c1757cb9db9ab01c569de4a",
        "darwin_amd64" => "b2d2f697b744cb4a20bb43f4a1ee87a5ba9b2f53dbd192a8bcf08c81d13d01c4",
        "linux_arm64"  => "26f2eb666e0c13d6e4eec8743b5e2fe9b5b471a729a2069bfd18a95263d48f94",
        "linux_amd64"  => "190189681e8b6fa23bc47aeaee613e7dee581031e1666bdebdef908a302062e1",
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
