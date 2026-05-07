class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.56.10"
    checksums = {
        "darwin_arm64" => "db98d50acab9cfe9231aed8a6a598b283192f12657427e1ccc275080f860c774",
        "darwin_amd64" => "4d95fb2c8a8a04ccfb10e39b796f2b3e1e8ea466cbda3764c954b3b3db24ab83",
        "linux_arm64"  => "4907215926d30d86fffad40c98d1f55fae47a356e4cfd7591110ca4d2cfd46e2",
        "linux_amd64"  => "6a8a5821e423504fe6d6a703703a2ab55354cfc45cdb6884fbdb4d9dad759c26",
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
