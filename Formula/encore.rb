class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.4"
    checksums = {
        "darwin_arm64" => "7cfcba76843a3e1fe42cffba0e94670f562f4cdca1773ee38fecdb9d8dee0ecd",
        "darwin_amd64" => "d2b139f4a229e3a9b15a54a5e071534e16d387ba4ad7a859e7e7386f2660f600",
        "linux_arm64"  => "d46a86b48b0fe68b3cd98e254337a5222772c3dc0fa5f76da008649a37604823",
        "linux_amd64"  => "69c2b5959f52adc9c249edba0562987da2d06f1f59926be52a410ceddd5734b6",
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
