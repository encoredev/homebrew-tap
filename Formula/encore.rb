class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.1"
    checksums = {
        "darwin_arm64" => "eaffba203a08a703c455f31674e23f68a95f1b60e5fd1000172e599894a276d7",
        "darwin_amd64" => "1ca9d004953be6dadc3358013ac5da292b51eb635664c3b1c32ed0e90e0e8887",
        "linux_arm64"  => "5b740d42d8719d6e717a546d1230ffc281875e09b44617905bb36c2855e0ac88",
        "linux_amd64"  => "3adf4d71432024de2354e2698f4d6629df6fd29b769d8e032265c1d34a4e5049",
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
