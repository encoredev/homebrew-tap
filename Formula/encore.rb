class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.56.3"
    checksums = {
        "darwin_arm64" => "b7bf57871202d16076fd0ddff93e9b4db0c02bfeb0f82e9997e0e7db81d216d0",
        "darwin_amd64" => "5bf177eeb330309fb6f616a27367c7c381be10ef4e3abe376563dffb437a4fa8",
        "linux_arm64"  => "d960465cc1e25ab4576d9bc4a9e3fd561fac2ca309892f2b353260b8c65d9cc9",
        "linux_amd64"  => "90ecc359b0051d7340c141eb777f0e585abd5fc5c56cc50ffff360985defc120",
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
