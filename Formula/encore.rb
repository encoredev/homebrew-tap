class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.16.1"
    checksums = {
        "darwin_arm64" => "a0467331f7aee1fa8d9baf1d47e491e7778383470d214e49c10b2e55bda92e77",
        "darwin_amd64" => "800c43ac43da5f6396b17aad605abd0e93d367e43cddb8fbe86bfe33eff2d49f",
        "linux_arm64"  => "d9bd7af0a302630f8b2e748c248b17602044ff54757bce2d74c4b37c3bd1fea0",
        "linux_amd64"  => "589ebda749a46ba96f7cdacf8ffa63c760f4f888dbd30f0d88d351e4445a8a4c",
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
