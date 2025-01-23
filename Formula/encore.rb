class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.1"
    checksums = {
        "darwin_arm64" => "81c4420b7049f037512ded9b2ea11807a8d370ed06f5d9f6cf324b5fa5a753c7",
        "darwin_amd64" => "a749509bc5c542b02201cdab6239e608cd429f88cd6334d43cacc46c556b9b19",
        "linux_arm64"  => "6f3f708deaaea948a31a9eb9551c403b2e9448eb18bb26b8752fa4314b87d072",
        "linux_amd64"  => "f3c6d1b16b6b75631d18f9bb4827fb01d718d116cd78979125f7d55246eee97d",
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
