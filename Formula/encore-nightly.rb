class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230325"
    checksums = {
        "darwin_arm64" => "1693eb37375f933e8c71e7051da7319c4bfe428bf0dd2b44313d3fbf6d191c68",
        "darwin_amd64" => "94517ebd98e1efba283ab0109c6d0eb9e48f95c847dfbdf873eb63562f89bf2b",
        "linux_arm64"  => "220a3ab75c64c423dddaa68166e88d2b9dfc18bd8fdc79e95ab6405612505e66",
        "linux_amd64"  => "334a3b897940216556fe01333f5b75d3085ab88ec57286c4f4d19a8c653883ee",
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
