class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230531"
    checksums = {
        "darwin_arm64" => "8255210e3118c202e4d60857f95369f57c95d5044b95a7b02f251b90fd64c93e",
        "darwin_amd64" => "1e01569b99c762cbb2418c492d51e9811b1430217b9136df5cce157236a0dedc",
        "linux_arm64"  => "7653bccbd6a26cc83fedf4f24c45534bea7a4ecb8d6551d7b0abcb3d21f5c0ec",
        "linux_amd64"  => "0d0bf84889153a2680eb3c2882e1a23aafde587ebda099c4bc2151dd7d1b8484",
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
