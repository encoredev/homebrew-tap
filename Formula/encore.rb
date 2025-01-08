class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.45.3"
    checksums = {
        "darwin_arm64" => "cde4ce052ad33cbdd9b1fbdb3634431bf5d2bcf553287672f35b599227b6ddd0",
        "darwin_amd64" => "a4ac3ccb480c0e2b0d99f725e66ddab964fafcc1290b9ea28f491179431e2b8d",
        "linux_arm64"  => "424288e190d028bd59ec86238c93c2b2746cfa6371f207f6913bb35dcf07b1f5",
        "linux_amd64"  => "1b0a40237c8aa3cb613d6f443c01ec5b5e4a64d0c353d399a4dfe0a472b6205e",
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
