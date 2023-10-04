class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231004"
    checksums = {
        "darwin_arm64" => "61075adb51d137ae68eb75ad700f58e26dc6505eb0931e142cb43db47dc99290",
        "darwin_amd64" => "1578db3e1e284f8b28498d7fa9e0a0be2c798447e244f597283eac5e95d28a4e",
        "linux_arm64"  => "dcd2ff5ad8dd4cef51e0d943bce85bedcbcd4654fa6acf0b44468e6c8ec84230",
        "linux_amd64"  => "6f38140955ea6fda44b31a4e1ffef2a656a84c5b2c7eb3e64712774cc8d08749",
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
