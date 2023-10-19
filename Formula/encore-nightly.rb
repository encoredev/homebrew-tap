class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231019"
    checksums = {
        "darwin_arm64" => "c498d6f92e9f8af2e3604bd54e524b09d28a1a651bb0ba1466f6f28d3a398258",
        "darwin_amd64" => "298d65457858650c780cbdca74db4ba31fd778d95fb2abc98d3c261a7ae88457",
        "linux_arm64"  => "1c1a656061a2470934a8396ae34d2d1ae5821ea659d4e2e2b11e94d55f93e4e4",
        "linux_amd64"  => "aaed8f04c961f7c01bb20c8582ecaf4f239288de60be672c761ef7c51fd2529f",
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
