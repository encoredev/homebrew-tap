class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.31.1"
    checksums = {
        "darwin_arm64" => "64ce4bf5978e3428c609b9a740ade7a56dd085c9492a02da59d213104d983445",
        "darwin_amd64" => "b98978537a46101c5c578edd51507781a1e8b746d081e5a6106220a218f071f1",
        "linux_arm64"  => "d84e0ed4bbec69a63bdd5d3b7675279567e4828e371769e76e253bf3483f3ffb",
        "linux_amd64"  => "4d98ce62df39d8975d79842ecc3fac7db3e5a2e05e9efb741b550594555371fb",
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
