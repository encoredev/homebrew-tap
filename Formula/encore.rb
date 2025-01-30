class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.3"
    checksums = {
        "darwin_arm64" => "b4f3293aeb51869a74d4f65b5205f947b40a48ab536d0a17de542fa09965f1b1",
        "darwin_amd64" => "3fa8518168b80228870aeb19784ea78be0ea30d5da88d0a06b8d504fa4052508",
        "linux_arm64"  => "d99d13b68e28afd5960447f0418e9faae50e44c12b172c774dfa919d4d712521",
        "linux_amd64"  => "c88542422fd5d6521dfb950a334d415557072a7460ee37626b2526ec4cf12a70",
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
