class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231017"
    checksums = {
        "darwin_arm64" => "45949f6966a04db4486df7f34213fc68d9ec4890d367a4002010523c20477078",
        "darwin_amd64" => "5428a97bfc486791167c1390e660454685597354fd2dff123031d2f5c486f313",
        "linux_arm64"  => "2813062a757bfcde167f1b4d096cd1bca1120b514e6e7a638c7cddd12db1cf06",
        "linux_amd64"  => "ca1ba154d377d6bc45e933954c9007a229ef0926c2ac20cf9e64a7bcc125cfe1",
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
