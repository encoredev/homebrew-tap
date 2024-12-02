class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.8"
    checksums = {
        "darwin_arm64" => "0991027d77a57e39da8bde73456d05f1bd69fdb54a2f75de5ed6ba7f7b0276e5",
        "darwin_amd64" => "325214c2c91afd11b5bdf067645d29a199900f79a91d1f8e1b4dcba7641f491a",
        "linux_arm64"  => "943da299552afc29ec7207c6fbbcdffca71bd7cf40be0ba63a152b431b736e81",
        "linux_amd64"  => "a9a16ff142bb467b5cc310f386bf186ff91695264cb30aa446ac88527e765045",
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
