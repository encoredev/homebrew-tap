class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-test"
    checksums = {
        "darwin_arm64" => "1fc058b44efaa2ec411615e4a3d6e7768b975b46b12da538f32b0621029a2186",
        "darwin_amd64" => "b6ce5bbc5d3f890757e5f058e280a23d591ea2ecd286ec989416666887418a67",
        "linux_arm64"  => "798cfad007b67d59f1e310963c3bab5534cc4502fa893325e482587a6980f783",
        "linux_amd64"  => "f3cb374e5496bda03efcdf932c651e7602eb139916f6ba61d1cb78d710787db8",
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
