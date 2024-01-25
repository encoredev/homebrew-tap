class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.31.0"
    checksums = {
        "darwin_arm64" => "6b734db4ac7d3c65d3fa37fa595be141e28792de4c5e28ac011405ff260e1918",
        "darwin_amd64" => "c9404abb9db0e39e9baf98472d55e49332943435acf3f66a3570cfcbfc55a79d",
        "linux_arm64"  => "2e187a5191b78db736f0f2d7a9b99e53a60eb67ad0931c9a4f50e6d5eebc0222",
        "linux_amd64"  => "67a6511891ac828db24a6b4eb0165cea8eb0669c839c98a328eed26c67b1b92c",
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
