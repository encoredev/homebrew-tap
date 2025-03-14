class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.9"
    checksums = {
        "darwin_arm64" => "151b1743284dddaf2a6f7d735003d4161149fdd8f43e9e0da549a149875e4a6c",
        "darwin_amd64" => "0ba630c8d2a18458c4112a9815b09b858b5da3a7f7ecdf4d45994cbf49853ec8",
        "linux_arm64"  => "ad38f1a6595ec603fa1adb9510037d6a7834ca7e9403745532a73eaa7dddd485",
        "linux_amd64"  => "70586e258f428e0c9785e37c8d2ea34bf7e3714c7280ffa686416642dc42e636",
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
