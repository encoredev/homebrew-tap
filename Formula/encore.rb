class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.24.0"
    checksums = {
        "darwin_arm64" => "37b618e5520bb850a9872b9415a2eb47648a53f148de14a105e97f3b35a10cf9",
        "darwin_amd64" => "3ea6669a3a55595e255fb4adc146ebb62521b69835bea9efa66c6c2bec4a408e",
        "linux_arm64"  => "349495f83d6b6976e90a67f8cd29c53a7e9155f8c31ea7d42132467b8b16370e",
        "linux_amd64"  => "96ddc41806476567d1b40181593cebbd88d22f5736289191cff77710b60abdcc",
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
