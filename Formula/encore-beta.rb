class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-beta.11"
    checksums = {
        "darwin_arm64" => "5bbf7473297bfafb6418d44ac8710e16f860a0a407fa0f64c0be34927932ec69",
        "darwin_amd64" => "49bd95a8789da44477057b10e5cd950597cee100e0138282435ac213767074d9",
        "linux_arm64"  => "95c95642a0ebe210fb14d1cf4ed0fa2b27c9b8660e4ed2133d4be3343a127373",
        "linux_amd64"  => "38a3e76f046257b2eab5a5fb51798e861c341d92532d47f7aca6cbe1519b6713",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
