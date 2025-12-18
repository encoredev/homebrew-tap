class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.53.1"
    checksums = {
        "darwin_arm64" => "8e98ecf2c6facb2ad530605c9912039fb2f4b9a3d71de93ed091648748c6ac42",
        "darwin_amd64" => "8e054360e0def9087677efde979aeb9536c5c097caa04e5d0ed255fcd7d52f60",
        "linux_arm64"  => "922c5955b2973002f68a903005d4ba37402fdb33a7295dd7793744401bcf3542",
        "linux_amd64"  => "bf2e372ff3fe3404f339fd4da4111fc5ddf1d3e5c68d7f246735ed545ab976f4",
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
