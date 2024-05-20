class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.37.3"
    checksums = {
        "darwin_arm64" => "46d53736cbd51964a42ba2e212719ea9442531adb8ebd4def95cd82af5956514",
        "darwin_amd64" => "e653f4db68c646ee7dff53fde7d8b1850cff17e48f6a0f5c9f96b5571b80c6be",
        "linux_arm64"  => "dbbce1f17da877348fa6f0700d256254960223ae0dd0173375a84a1c294160fe",
        "linux_amd64"  => "695e89a8b7b183fdf8e597fe39965d2f7c6f567b589eed03b34f339fa8ca7ad1",
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
