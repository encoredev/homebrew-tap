class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.56.0"
    checksums = {
        "darwin_arm64" => "63c00330900b1d6311df11a04a18126f11b5fbffcea2cd318c3347eb484a2ec5",
        "darwin_amd64" => "28ab437d2c594f3c00e3918fe0d577c9fbe248e0403a49f4d391eda5e2d858a2",
        "linux_arm64"  => "ad8a23e3a646fd8153bd787c63d55da3173898b06d01f4ee53617fe763df9bf2",
        "linux_amd64"  => "44f42901268b255f64613f4a418563f2b789469147765ff5d1685045ed2ba494",
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
