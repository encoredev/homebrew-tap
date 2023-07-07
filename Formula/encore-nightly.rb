class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230707"
    checksums = {
        "darwin_arm64" => "a03391d09247b3ad509b82802336b4b7f52953acc745305a7948776d519dd76d",
        "darwin_amd64" => "24b2c7c89ffbc72ecb480f0c2741d1e7ffa8453c63b7e6755c95355470cb09bb",
        "linux_arm64"  => "e5c0e2e511bf9ad911262e4ccefd3031fa251a8fd883f85f72cb7559ce38e00c",
        "linux_amd64"  => "8228792e2749071f3268b69ce26bbfe70f6a08f7690cd26818d797d84dc4c4aa",
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
