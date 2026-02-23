class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.54.1"
    checksums = {
        "darwin_arm64" => "e3d073c230b95457ef22fb19a67645b44fba216d3f8a44ea70cf2d0088edb902",
        "darwin_amd64" => "bca92dcc02b53b298909f52f96f9bbeaad12e89dae2587a22e426e48f456f31f",
        "linux_arm64"  => "7700cbc9fe0d1c4219b55d10cfc335e23601c0b898dbf21d7d7140b0c2981486",
        "linux_amd64"  => "b12675784c0fdc315c6d2d5fdff12f5fff01335d4c6f66be10e14254e2a099e0",
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
