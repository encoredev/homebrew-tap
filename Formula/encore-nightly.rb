class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230330"
    checksums = {
        "darwin_arm64" => "f78c4901191f39dddc582326d0d373381599304fccc4dd05939244ac8e6b2100",
        "darwin_amd64" => "ddd13f68a6859b6470686a886bc3dd8333637d716408d94120e92dd5b1f0f73c",
        "linux_arm64"  => "474113ef480dbd17d11e79c1cf75bba53e188692501528a2feeab82771dc6e6e",
        "linux_amd64"  => "e8d4d417b295b4d6db2f93ba3b53610a27201bb19a9035a520c8115e9572c7a4",
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
