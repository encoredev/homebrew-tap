class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.4"
    checksums = {
        "darwin_arm64" => "06ce906e97cfb9d8f42393acac651d502fbb127493e3691ed9d772f784e01f9e",
        "darwin_amd64" => "bbd44f248dee4dcd96d6c087a27ade485df567c7dd04bfd3182ad67f02c6a394",
        "linux_arm64"  => "0b33b6ea15f541949bbd04fef70bfb2416c17ce65570815e2d3ff3738efbc489",
        "linux_amd64"  => "f2d3b9c1eddc3249f6149cd111c8a8d515aac8bd2661ad29c6ff8c843232ea89",
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
