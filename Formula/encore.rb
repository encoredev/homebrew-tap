class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.7"
    checksums = {
        "darwin_arm64" => "5bad69e06aca9581a9454953cce0067f2e4b417ba22f763c0eb0b1c4ef534ff4",
        "darwin_amd64" => "a9fc01b09ade5bf6a6e4388081729c0f502519f92a1fd8207842538e3d1d50bd",
        "linux_arm64"  => "80a08e913a13e9563394a6e6eda0b23377e49406c5671655314d660a10093082",
        "linux_amd64"  => "29d62f3e596bf951ab21a58768adbe053a94368463bdac7106fd880749b9adce",
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
