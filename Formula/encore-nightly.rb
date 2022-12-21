class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221221"
    checksums = {
        "darwin_arm64" => "dae3e64b5d3eaed042317aeced040f85d1bc849d51bab1c211a4c9376a2e9069",
        "darwin_amd64" => "b2a9cd648664806979248a8c5271d8288a3a25b7667c6436ce6b018b740e13bb",
        "linux_arm64"  => "a1a991a1f164fc4fc48cc42518f638dcfb756be4dbe79a0df1a4a6d267d729e1",
        "linux_amd64"  => "16ecc5fb40e753578cb23aafa80deee736ff1502b92e05573163b6be88397a08",
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
