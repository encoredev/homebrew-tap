class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.39.0"
    checksums = {
        "darwin_arm64" => "f71bdb1e67947ff1c87bd55d680522e935da54420875ac0575cfa4869e984e6b",
        "darwin_amd64" => "b1c7f4d3853d92c8dd5486c9b494afa61baf9e48eab38ba00fd543a2e46ef01b",
        "linux_arm64"  => "645d8c4a50d16ead99a3cc468c04c0a7e578d71972b0e5fcf05748a01c2b8070",
        "linux_amd64"  => "8b8ef03bc61acae5a9cf90ad08c6cf4ae9ac45e3c6bdbb6626aa769ce270f196",
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
