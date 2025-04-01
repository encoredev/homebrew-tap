class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.16"
    checksums = {
        "darwin_arm64" => "91edd5363ab1569a8b1775c2c056abd5d2663c6b8f971c22e627ff635af0880a",
        "darwin_amd64" => "796ddd0e77e2fc424378d8647b74158194cd81b694c8af5eb044923cda144ff3",
        "linux_arm64"  => "451fba1f43449c5d2d37da7d4fce7a7b82244ba03c7e481f19779874a56efd22",
        "linux_amd64"  => "57afdbfebee76965462360d3de04091471402a27e70eb26a83030a403cdd8b79",
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
