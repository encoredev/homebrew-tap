class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.45.2"
    checksums = {
        "darwin_arm64" => "b18cc2a4a1ff72dff3d9fe7b92af854f6ece05976a103e724a2c5e8f68bdae57",
        "darwin_amd64" => "82e98035c7675a217f824d35a7392b1f287d9bb281accd35b2a86a44a0038421",
        "linux_arm64"  => "877195617dde69b5e02c16f04968ad01546ab3cc90ee333b651b4409c809e9f2",
        "linux_amd64"  => "2887fbfa80fd1903d14aebf63e4b6ba7880f004d33e4a00e7b9a2e43a80048ed",
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
