class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230830"
    checksums = {
        "darwin_arm64" => "2780e157bf4c4eeb347e056307baaf0ab5c48626efd5a58bb0b296ef98ec373c",
        "darwin_amd64" => "2476bba32c5e7f5f009ed6bdb149b212b5614905384e829229cf384f4ce6bc6b",
        "linux_arm64"  => "593942efa6e7c52a033bae7274562a2b12433e16741ffc8d1d9df2b1246c5d54",
        "linux_amd64"  => "d97f8d4fd102afa57e5befb136f2317e16bfe5e619d796f231d3e70a920ae742",
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
