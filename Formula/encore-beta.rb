class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.24.2-beta.1"
    checksums = {
        "darwin_arm64" => "e690be1eafd26a60805273e03e2f737be3ae9b2e0b2c9009cde72f947519bde1",
        "darwin_amd64" => "e10ee024a01f4a4f3eaf367ca02bd0882355f6e8649e1331d42dfd701033c5d9",
        "linux_arm64"  => "f506c826e7e617b7e6d3c40033bb580029ee95dd3e443cc6ecc644777289a722",
        "linux_amd64"  => "0c4f86829f0d43bd88df5fe71b0d9aacab1848496597440ddc9dfb69b0105d43",
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
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
