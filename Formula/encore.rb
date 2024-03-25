class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.3"
    checksums = {
        "darwin_arm64" => "f25233a73bf42be5201d53b42b9e23becef7b056676fe18f1f6ed6bce8941635",
        "darwin_amd64" => "0b88588655074d8ffa6f2db72be5519d5fa3bd2a97e0ee77c83e77279c4e5503",
        "linux_arm64"  => "67456d1a397ba949e8b1b5091869ad2318193b8794e8899ab5a8c558bf567a14",
        "linux_amd64"  => "807f373d017dbbb54b10130af972492e4008bcf4d6744a62122a28e16f87785d",
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
