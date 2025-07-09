class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.9"
    checksums = {
        "darwin_arm64" => "1eeff4798f54319ab4d29690a5b17945a05312f84fdfe9b13dc0f6b43c540ff9",
        "darwin_amd64" => "021d6c3a8d14114899ad31c1258acf8164a554b314fffb8fab8d0a868e673412",
        "linux_arm64"  => "036ccd8816ffaee6c884bd454f8f79f5f94e29ad23d1ec91e2375500965e94f4",
        "linux_amd64"  => "775557d9a7770da068a60ddc3c7b34beea2a11c50f20485f8b2169b6937d8647",
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
