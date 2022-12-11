class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221211"
    checksums = {
        "darwin_arm64" => "4a444fad0ab08183a79a4a04601e92763d6a1996488a6583db7617ed3dab6192",
        "darwin_amd64" => "bd04107502f1009d16cb5d6de3041c1e75041c8674e59e47acff704549161a04",
        "linux_arm64"  => "216f8a626ed4c8b5e59522582be89ab41ab875ed0a24bc50298027d795361a85",
        "linux_amd64"  => "8973a8a207e7943710cbd73d91c2028d71766f5cc5aaaa675dc2b603dc71efcb",
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
