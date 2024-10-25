class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.1"
    checksums = {
        "darwin_arm64" => "efb5cfb6a8f1703a304cd5c2965e43323b1a8f66f409729127cd6e84e2c86a6f",
        "darwin_amd64" => "e555a444f557af9f46dce47a3bbd48634587966930df87f1dfeec0fa1da85a8d",
        "linux_arm64"  => "f0166d7f1e6a3092385d31be24d7aeb07a798036d00e74a6a2d3926e2985acde",
        "linux_amd64"  => "58caddfcf57b4ed6fb54b3258edbf5cb92b1541ac906d85da735f1925ca6183d",
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
