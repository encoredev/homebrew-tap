class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231009"
    checksums = {
        "darwin_arm64" => "e188f06ac37b7685cbd72460edc7ceb3332593cab9684308d102fe6e5b5e908e",
        "darwin_amd64" => "75a4aacde74f01db15b6e45ac08a2e2221b746fa18d6cffe8e4004ab9c3d0383",
        "linux_arm64"  => "16f9fb5286213c5c6b1b221324fdd0340a5e314cb4264350ac30497b30a4b368",
        "linux_amd64"  => "e4d692bec1da83b50f28b3810e67f80f1bbd210f33c038521cf66707335055b1",
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
