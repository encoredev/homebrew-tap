class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.37.8"
    checksums = {
        "darwin_arm64" => "037ee6865df9770f0cdf71a6a3ce07538641c033064e5e820b147fcd87769951",
        "darwin_amd64" => "7b5fc34b9843c8cfdc55dfa6a283c6cc44a0086e406e2e465ac73aa0a86b562b",
        "linux_arm64"  => "43c8273d676182f9f22ac5dd3a71821ee084f769eadb36bbfe40bdfb1df454be",
        "linux_amd64"  => "59704eade7677180f53d663d941debb6509e42557a6efd7e0d6e2449d4308602",
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
