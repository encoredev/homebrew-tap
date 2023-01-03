class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230103"
    checksums = {
        "darwin_arm64" => "540bcaf9693029bb930637065df72d6df1694e824085e89367bf2c15b935d7fc",
        "darwin_amd64" => "561f57cda340029a28377d3601d7e847d4ee937c068a0e01f1cf0a5b02604a6e",
        "linux_arm64"  => "5867b417b82a54702ad1d3192b30210aa38a411f717c8731f2051285213e7b48",
        "linux_amd64"  => "4f183492746e45c2da326052d6595aa1d77b47474b8771957eb9c673aab5fdc3",
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
