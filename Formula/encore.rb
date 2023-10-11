class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.27.3"
    checksums = {
        "darwin_arm64" => "dc16a299f803ba96444b24149a62c31caf3eb11dbd35458ca1762de6b24fad9c",
        "darwin_amd64" => "92c484cff1fce4fb9f40fe4c9fa160586263e63147e527a3ef0fbac7b185858c",
        "linux_arm64"  => "51df7d435e6193f23f6afd792e4810c41af86fac92e9763811475d21c724eb84",
        "linux_amd64"  => "e02d51d42fa05acffeeafb240a434bc2262d60d3f9861b7185b51ace8c386a1b",
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
