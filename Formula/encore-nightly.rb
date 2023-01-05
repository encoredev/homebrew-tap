class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230105"
    checksums = {
        "darwin_arm64" => "78e828ff5ab7fd7c63c3798d9cae1de71c8fafda826f33d9307c6a884a63c64c",
        "darwin_amd64" => "f66adacf31aa5a5f2b0f6ffd2d456dc24e6462705eb8fae29b7a1330bfbaae31",
        "linux_arm64"  => "8aae3dd6704db5ce405301f9240db611f1b2eaa0c9ffd846d87929077d77cbfe",
        "linux_amd64"  => "7ada700ff132c10bd5e693e4b044e1808a472ca1141c7b979ea5483fadbb82b1",
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
