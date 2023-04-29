class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230429"
    checksums = {
        "darwin_arm64" => "c6aea75637fdca2bb29d3a16de9a2c4643d1450d4434339b4c421a73884ead88",
        "darwin_amd64" => "882543f94ebf00194f050100ca62d6a20405ed194fdc3276c0181ad0aaba31f0",
        "linux_arm64"  => "46f47fd26432c3c5450daacfb64dc36847418188aedb7c2b27d7704cf4eebfe7",
        "linux_amd64"  => "ebf26c21939fd51c5051bd7b296cc6d9bf7d6054191e13cb82e8dce9b63976c4",
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
