class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.51.10"
    checksums = {
        "darwin_arm64" => "3b7abc0c0606788ae63fb2d96f5770099efa12b86b9d95abe82d574172c9b877",
        "darwin_amd64" => "2e882eb16b9a7ffa0974f6575e7f8bdf19e7868fda03231ab75b08a3abef24bd",
        "linux_arm64"  => "c6aa44f379ccc74f79cee424180d1a2871b89c9d52ba05b8a4d28deaa44fd184",
        "linux_amd64"  => "41307cd81bf66d4e6628627b03908697715762b0cd61a64cbb915fc82b7d24de",
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
