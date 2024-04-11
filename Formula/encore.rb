class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.35.2"
    checksums = {
        "darwin_arm64" => "2f21aff934fc7752aec2969a84167087bab7b49aec6143cc33f9e1d046d18ac0",
        "darwin_amd64" => "99551165c07f92c2e5b0aad33dd9bb957e177011779c18eba943172552331f86",
        "linux_arm64"  => "535fcd1ba57211aab30823bdcabd264016f9417c18837bb35c61db71f9d24b40",
        "linux_amd64"  => "19934190dcac584947c4d4d363d05ef2466c594ebd9f5f85a43ff870f2d86401",
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
