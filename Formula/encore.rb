class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.7"
    checksums = {
        "darwin_arm64" => "a93ab74f7fc9e2a62e8b69eb0e3d61416d58d89539e623433ff42342f8655f9d",
        "darwin_amd64" => "03be26da7cae729b6557d462d29a290d7e53217522705c0a444e68140580dfbf",
        "linux_arm64"  => "71f89c8ece67ee30dd53e18f055e74e85a3b5bed9592362ed58f3342b5ab8aea",
        "linux_amd64"  => "afdc8a0db89600cfe6e70748b2873b65898b4e8917a0148472df3cc02261146d",
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
