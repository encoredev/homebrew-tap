class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230816"
    checksums = {
        "darwin_arm64" => "2dc4412c17bc8e0f39f6dd14117498b45f14fe0387751e891baddacf536df900",
        "darwin_amd64" => "c30d5fe471bda71d9cc5288fcc474ca5d45c906782daea1bbf55afb5627a6126",
        "linux_arm64"  => "6b939655baf519486bffdc6d183f536f7bec96a4184a3eac32a3a5f78b5b9d32",
        "linux_amd64"  => "344610ef6ff9923429e41b49f472c2e5687c45fb5da637540e14a33f35a80d8a",
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
