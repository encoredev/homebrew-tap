class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.51.4"
    checksums = {
        "darwin_arm64" => "90b97ba81325da91e9d63eee108aff8676dd2359234c1d4c6f9cd91c5a2cbe90",
        "darwin_amd64" => "4b546509eee8927b9d2df12564b0f91a48af7f2231846d1822ae24559ec85f4c",
        "linux_arm64"  => "f53ce28c61202dde6c9480abbc32715be97f8a0f23333dcce48a63a34d7a4daf",
        "linux_amd64"  => "54624845e9668af29c6debc2f4b040d647f4e9fcac32c9631346e396c45f8e42",
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
