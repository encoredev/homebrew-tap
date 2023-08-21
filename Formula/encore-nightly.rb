class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230821"
    checksums = {
        "darwin_arm64" => "c52b4b88187b732da31004f12ae6d0377da90b1c912a881dc38d309f543c0d6b",
        "darwin_amd64" => "249d67f1a10e68e7c4884581d6baa231c565b138abed950cab63668a53eab129",
        "linux_arm64"  => "8138d1999ca22dbcca64f8bae2b59d39241b72d046c1f7027fa49e908bd398e2",
        "linux_amd64"  => "c290498edaa2f7ea6e74e8d1bdb4abfd8f82feaeb294b252b9a6118399dd3286",
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
