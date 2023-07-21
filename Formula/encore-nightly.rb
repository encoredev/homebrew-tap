class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230721"
    checksums = {
        "darwin_arm64" => "3561d3a9fb44d3b011c1b053720cbfa11458cdc750f5a4c400bfa74e5d5ea027",
        "darwin_amd64" => "f0ac8d8f061c9bf0506e68a773f0918d4a3cee4b043c312a4ed36d8a2d993be0",
        "linux_arm64"  => "8f5efccca25770e7a92c39330a613a758a0894f6723f6aeb8cecc41af78f82cc",
        "linux_amd64"  => "7d50a90b6d05a09a1a51c249b841d8957da3d438923fb8a5b83817695e8eb5fd",
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
