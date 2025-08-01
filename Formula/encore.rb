class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.12"
    checksums = {
        "darwin_arm64" => "80c799f02492cbeff8d033a65da4397e66230e24b85915a12990a90c994cadc4",
        "darwin_amd64" => "d30e453395d48079abcbcc5801d4475dc8abf404de19837f889225fcda2bb9a6",
        "linux_arm64"  => "63df8f9b16ead08bd43472b0121454c04253366a805bb603d69fd2228ad2a434",
        "linux_amd64"  => "2528b203c2bb869900804bf745a605316ae568e192a485d60734d6f724ee7663",
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
