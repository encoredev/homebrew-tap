class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.10.1"
    checksums = {
        "darwin_arm64" => "a4473aa6e00b33774a2d45eef9cd70cc18671578f69afc7f038cde38164bb836",
        "darwin_amd64" => "ff6c1f67c202e886dad83bc5b80cabbbc378d4062773f07006b12ed34c0ac1a5",
        "linux_arm64"  => "30c4b7c45bd01d539542f24a6cd49a05e8f6a16f2f0d58f350cb6628f09e5520",
        "linux_amd64"  => "8b9d423832724219e37aecaae420290b8ff9785ddda554d7c0607fbb3aefbc35",
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
