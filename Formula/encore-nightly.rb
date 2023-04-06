class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230406"
    checksums = {
        "darwin_arm64" => "de8ce81a99ba352f702ebe72a32098f09b8856f02b7392cc3699e581e19046c6",
        "darwin_amd64" => "8d7c647470b5abd3786ff27af93b4a3743e6c5d26bf5b2e3028dee5d479836c6",
        "linux_arm64"  => "9afb32ad077c1b2dc1686eb9f9797a6e4b19fa502f5065f5ac4a3d34a1478ee0",
        "linux_amd64"  => "74e56b016dd7a86f9a10711dc31d4670d63ae689f585cb4d1d350326e037ac1b",
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
