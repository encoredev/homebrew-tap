class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.7"
    checksums = {
        "darwin_arm64" => "d2e97a95e0877b4455b67e3280898489c51081a33df33dcd5f077ec4221f358e",
        "darwin_amd64" => "00ba772e55e8868bb68c9f3d6a30e749c10ce0e3b2f370098e9b4e3c6975dd80",
        "linux_arm64"  => "8332ae948dad6d975320ca29c9b473f7e7f72fa3ba62a9b1f689a9f9bfcc192f",
        "linux_amd64"  => "1d1876c78762b41ef9f6de1972be8d422ee91787fbf556e2fc29ffc09ddb5d8d",
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
