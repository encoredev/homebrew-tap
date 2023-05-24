class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230524"
    checksums = {
        "darwin_arm64" => "f80f21b5ac2841c1cf25cecf81865fb99ef96d4f97205900a1c2ac32cba3f322",
        "darwin_amd64" => "288a7ed8abc71d65971d8f4243780c03ea8dd47a4a10ca95737cd72f61e0b4ce",
        "linux_arm64"  => "2eadb9166e3c8a65ddde189935d255ecca0698cd4125a8a2fc22a66319171630",
        "linux_amd64"  => "4c1e2567300a72ff1ab63922f4d7252a9fc4237d68775e6b65abb9b18bb5eb9f",
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
