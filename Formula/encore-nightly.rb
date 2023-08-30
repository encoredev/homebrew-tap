class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230830"
    checksums = {
        "darwin_arm64" => "db0a3b1bc38e540fa5f629d74ea52fbfc3fd0e0e6ef3b8cd4c667f0f6102e3dc",
        "darwin_amd64" => "15f4f7683ae881ce39d30d194fc8c268778aa78682a6355cd0c981b88adeebbd",
        "linux_arm64"  => "658cd971f77828ad860192c732dc8509b23d672192e3a855ac0e50dd4f55c755",
        "linux_amd64"  => "86ec58a06f23fbd138f0e40dbc316cbb3697d351d7ea66c547e4482127e63424",
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
