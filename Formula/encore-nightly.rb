class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230520"
    checksums = {
        "darwin_arm64" => "a6d26a5f5b1d9ecadcf4c97f566712733d527961d46b68448454d5b253ee2168",
        "darwin_amd64" => "f767c4dc0bceb0d3488283cff95f2ab35603ffb1cec8c6750bea1ddcc99f9845",
        "linux_arm64"  => "8fbf23f7e22f991c32b5d365ccbd93968fc5db33c7c992abfba71bd01283d560",
        "linux_amd64"  => "322deb54876681b81daee6c306f1aba6468be0457891c6acec54b0d0befc4c68",
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
