class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.38.9"
    checksums = {
        "darwin_arm64" => "d2b3920c6ac9a890497d635ffc5aaf02fd55ad03c7f9da4add50167d4ad97bd0",
        "darwin_amd64" => "7fa7aed4510aceb0c33f21964bee925f73058931ad7663f0fa42d073a6d09bb1",
        "linux_arm64"  => "60bcb12d0592c65d79a4515130349efd6778f73c249442b0babd8714dde9ebd4",
        "linux_amd64"  => "b6a406a83f8e606e6877725c05e57a6d8f1c635ed462e94c041aff1b6ab299b7",
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
