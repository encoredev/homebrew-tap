class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.33.0"
    checksums = {
        "darwin_arm64" => "e5ad5a59af3cf3b7b977717540715ca077d44d68caf66eb7f6f550a5a01f2fa7",
        "darwin_amd64" => "4cf964d2eedb37aeda85deec5b5cb6dbf794a5092ead2fd030a2f49e5c836f1a",
        "linux_arm64"  => "197a51a78e2fcecd30dabac133156311b4699c7c23a2e2e03f0ed732e4d17650",
        "linux_amd64"  => "ae096c5a3b55cc838c1233fd0f44f1b8d02900d40d6e07599a4d3df5995d0c2d",
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
