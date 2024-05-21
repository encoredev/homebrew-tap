class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.37.4"
    checksums = {
        "darwin_arm64" => "ed5b7a7bd21f1030c585c2bd85316d8a2a9d7d82a7747d1e4a20dfe98d59991a",
        "darwin_amd64" => "d520fd2f170fce61dacccb7b838475825bb5928cb14220f051e869b4d094ff19",
        "linux_arm64"  => "c2c6f57a15990b224dd3e9baf02460c76f2fe63b201bdd89fa977594f3353a67",
        "linux_amd64"  => "18a8590aaef110ace05b0697ead0d758e3c05c538bed87bcf972b8ed9b6d3d59",
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
