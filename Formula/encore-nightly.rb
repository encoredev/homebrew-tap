class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231010"
    checksums = {
        "darwin_arm64" => "34a8903c0f9bcf216e8c139d34fe1bfd3ad8ac51918954cfcce69f0693d5f758",
        "darwin_amd64" => "a9d31030b7f7e4b0ac6f6e8bd1ebcc51c47a8036424a7eaf55dc856999beea6a",
        "linux_arm64"  => "9f11673e7eba4273ea1d6af29520ecaa17060af4465f1de577a7289a37ef2b32",
        "linux_amd64"  => "7959cf9f9011539a7b6b502583ab2849898011d6090371ad0291119f74965e83",
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
