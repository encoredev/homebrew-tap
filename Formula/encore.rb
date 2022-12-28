class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.12.1"
    checksums = {
        "darwin_arm64" => "236e3c245dca6e67fc2780aa8e14374ed7a4bd8f0e20745445309693b5667fa8",
        "darwin_amd64" => "ed9ec112c26adc5025dc57a7fdf7b6698aa95e262069f691705c0e4a0c073be0",
        "linux_arm64"  => "2cf697bba0adaffd6fe3a49fad886671f0699eba176aac3b5aca57e308d6bb4d",
        "linux_amd64"  => "d0391350033b0a3f27c51af91ac1a50453deabb6dc812e15af093bf526d507b7",
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
