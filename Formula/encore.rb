class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.0"
    checksums = {
        "darwin_arm64" => "4cd7a6c1338eb72d22662a06f6cf9ebd130189ee213d4cd01bbccf3bc40e4257",
        "darwin_amd64" => "25286ddc724d087914a8b735fbec76e962bdbff9a9b18b136e07614f0bf05e8e",
        "linux_arm64"  => "36eca5d415cf46d0ac90850d428da4319438cc305a87c11a7f140ee741967b0a",
        "linux_amd64"  => "dd466117d260942bcd111b3a4f665f193aa7c9530b346ebb5d4156b8a52323f1",
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
