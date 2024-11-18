class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.0"
    checksums = {
        "darwin_arm64" => "88f4366a2a21f9da91aed36773e843d5cba661d7b33483c738f19b87569e2924",
        "darwin_amd64" => "da4838933e4632bbb48a1c98481bd949d2211576408a9837d689b245c0d15c43",
        "linux_arm64"  => "f545cd3a7e55b51900594e259fe7210b254e47defa5d0ae630e703ddce84d7c1",
        "linux_amd64"  => "2ff83bafe370d8b5d1f9e0276ddc64a12af32cee9d431674cd0ff3cb6b89e36d",
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
