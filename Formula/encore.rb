class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.56.4"
    checksums = {
        "darwin_arm64" => "865abd40a7c7ab872538dee50b8c89e66f01edd48437c3eac6992606a22f51b9",
        "darwin_amd64" => "cf80f7443a0d363ac574bac557307769f9adcdacd7ccee74bcfc5c737bdf261c",
        "linux_arm64"  => "425d8f25f7c2650a422b2ebc4bd72c46501f8f83e2f368a69143099817297ff9",
        "linux_amd64"  => "f0f485e5c63345f136ddc11a464aec2e5b3841dffd7d7ee73a5c33e9e8cf0c08",
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
