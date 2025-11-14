class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.51.8"
    checksums = {
        "darwin_arm64" => "d418468505eee0c5d787421e476311c73e005fe85b953bb3be666796f8dea0b3",
        "darwin_amd64" => "acadfd386e4597c696c83689d13c7ebcbf42501de3aa1092c3000defe39cbd5f",
        "linux_arm64"  => "a5942b3d489b0992e4a601db00e0c5ba0733c1bab226386cf8183ec75fad7354",
        "linux_amd64"  => "cbe7b85d89430418cdd6603aa9d174854c246c0446ab858e703a8529272c74b7",
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
