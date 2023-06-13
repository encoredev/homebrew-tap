class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230613"
    checksums = {
        "darwin_arm64" => "24b643b921d30e19d5608787abbe21073824d9186664f5f445592fb7ad50632c",
        "darwin_amd64" => "0de39e29fec2fd60086a8c9c89ebd1d546168fe9ba2462f5d7da4f5c490cd502",
        "linux_arm64"  => "4b4bd65998f9b67f436eed9c8d217819c52b53571877edde6cb0a678c9c5d3ef",
        "linux_amd64"  => "ddb887c31ded17233033e79624a72bcc4144e5b172520366a094e242bb78a7da",
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
