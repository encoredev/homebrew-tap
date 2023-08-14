class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230814"
    checksums = {
        "darwin_arm64" => "b7d539b94c2ddb8153cb213afc2f995ff634a1ae58c0e6f00265ec19700bcab2",
        "darwin_amd64" => "74e19c73f71d36df5a919bfd80d04bfdb13189b87e52d472cc46e8a26a49f2cb",
        "linux_arm64"  => "4edd5d9798268ed5e63364d3abd8e24e1d5aaf07542d20f4daaa5fa559628036",
        "linux_amd64"  => "e104a6b09936e4bb67db0111dee4aa8a3d7807d6d2724f1012f5e848cfa6eef0",
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
