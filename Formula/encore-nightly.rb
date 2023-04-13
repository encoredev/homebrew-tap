class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230413"
    checksums = {
        "darwin_arm64" => "c6195fbae1e120f4f48ad2cba359e9d514723972ebba4001775aade321edfc51",
        "darwin_amd64" => "4eb61cf4240fe433ab99c6989cd6ba2ee29cbf6a8c960dd4ec9463321608a954",
        "linux_arm64"  => "0bd5e5a5cfd531d6b10e16547aadf07caa07ccc755331c6213dedcca6ce5f942",
        "linux_amd64"  => "609b654433d7de4d9ac3b40254028185b5b94b3fa9ec076c4376bdaa76e7a56a",
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
