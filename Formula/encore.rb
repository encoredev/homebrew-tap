class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.5"
    checksums = {
        "darwin_arm64" => "8b5677e091064e22d11ce0ebad986b6ecde5b8a5464a0e02c8d68b4dcd870b88",
        "darwin_amd64" => "33fc3d6f8e77d2b8cccb4ed92223e6ca3efe35950f0d49fdac85700e5d2827e2",
        "linux_arm64"  => "c898d6c1cfdf42da787681424a2dafa37bb8ba22846971cc2b928798c1c7bb91",
        "linux_amd64"  => "ddfc069b2f473c0dc5f3a3de8cc6f0f2bb356685879cb86659ccff5f8a92416f",
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
