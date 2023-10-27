class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231027"
    checksums = {
        "darwin_arm64" => "9c7516b4821115ba035a2e7761c65a748c6e27b2bbd343a7c8a6eb289f306875",
        "darwin_amd64" => "823bf05b768817931f76efb67ad119bf8bbe7ec2f22331e423f67634a4d5526c",
        "linux_arm64"  => "ea61c6b3dbc6132b934b14b7cfdf416e9f0c53fae50fc2a4e716c2be334551e4",
        "linux_amd64"  => "32e229d1086746acffd8d5aed163b69f4a55c0c8454f8353d34b0298c639382d",
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
