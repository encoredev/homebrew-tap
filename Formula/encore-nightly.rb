class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230714"
    checksums = {
        "darwin_arm64" => "dd48beadecc9fbecbb2c405a8e80f332d0ebccf99318c5130f8f53fdf3dde365",
        "darwin_amd64" => "e0e72d21d197568690bf2e4da0f6a0135f4ee26f42ce07ca547d805c6ed53b16",
        "linux_arm64"  => "176e12a55e01b6f75893d4bce06358420518b5c53e365688dc5cd4d7ec92df4e",
        "linux_amd64"  => "50d66930d04329f4c5228f75ac793a9e38ce5b5f51e870f6d07f030a9a43145e",
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
