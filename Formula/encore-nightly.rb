class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230211"
    checksums = {
        "darwin_arm64" => "d432658bcbbb07d7f52bd6df9c931c33678de6aaef25da55a38404f2911282b0",
        "darwin_amd64" => "cf7b98e3530ee0cb52f097d411596f7049e326b035b66489a40f0c7baaa8efab",
        "linux_arm64"  => "a940971f93edbd161db4e29b43da7faff9bb40dfe763c48e857480cd51d3a613",
        "linux_amd64"  => "12471d052377c2d2d73b6246b5dcb202888f3f596d0f4e5f33f19dd5d11b3219",
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
