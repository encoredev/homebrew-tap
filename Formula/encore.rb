class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.13"
    checksums = {
        "darwin_arm64" => "f189819fba26ac324942a40731d40a96b83050880a0b0b2d8e39436d426250a1",
        "darwin_amd64" => "67fe1f10ec3adfb64fc1323505e27a1a6fb0d2a4956a1fd5fd94996ec8c69eac",
        "linux_arm64"  => "48694dec1cd5d28099b89a249fb74e7d0cd1319b58d88bf9b17d7edcbc367e93",
        "linux_amd64"  => "b8007b7ee6572f5f6f84f6b7c48da915f2ed4eb82cef731513efb7e081f69399",
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
