class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.35.3"
    checksums = {
        "darwin_arm64" => "4336ca35a66820c8c15650cb6a7482d661f1ed02f4c1dfca8e525c2df9344ebd",
        "darwin_amd64" => "8d64cde9fe7066f2b89f812612b2192efa2c86230ce1764991ddbf4910742b24",
        "linux_arm64"  => "8a612b361523603f1a198d232629654e08b10ed2b54de3fdc55000a33cdc5971",
        "linux_amd64"  => "4d8710885ac8e7d3ef313f83e1dbf3e798cb8e732c21a938c71bf990ba4a5ff8",
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
