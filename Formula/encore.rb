class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.57.10"
    checksums = {
        "darwin_arm64" => "77d4abcdc1db4a4a1f0bfa5bcb7dbb4a0e981586c27323d7a28f0aee843bf25e",
        "darwin_amd64" => "82c5ec88c0c45ca6fde5656401f921ff41ac217dbb8cc252372daf7a4b390997",
        "linux_arm64"  => "fa1b248d3217d5766c773dd5758e6970209139900401c627e9420474f5e1273d",
        "linux_amd64"  => "f4ebbdcbbeaa4db927e186cf44c59fff0f81c808c9145a364027e67cef44ec16",
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
