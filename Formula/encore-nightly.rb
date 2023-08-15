class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230815"
    checksums = {
        "darwin_arm64" => "2f800b236d7962252e0260120b8b6bc938d2124e1bf6517b18042142d503b374",
        "darwin_amd64" => "21837ce25ed19f406cb26cace2b15b6a6e51795499ec7728a494a1fb1df58da2",
        "linux_arm64"  => "cac839fc2e9d297305963acc4b433d1c51b42f631dafc6f74a3a8f33f6be5afc",
        "linux_amd64"  => "65cf5f3b44dbbe757a2c9c57a35b695c0fe7bbaeee48c1ec6fc0521710f3dc19",
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
