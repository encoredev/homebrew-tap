class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230113"
    checksums = {
        "darwin_arm64" => "96ff455f8490bcae241999631abc5804ac3e5e04a280d34fc41d920a387088db",
        "darwin_amd64" => "5b65051d9a88b1081bb676e08c91d82d6b553ef83e27dec20357f647fa8fa514",
        "linux_arm64"  => "49cdd837e3cdfefca8ce38ac638e0539a459bef95b0dbd15534ec2a804f21a26",
        "linux_amd64"  => "8acd26fc7b3fe2ac22612d68acca0f228620b41bcbb318004f939bbf3b5eb2d1",
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
