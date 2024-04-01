class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.8"
    checksums = {
        "darwin_arm64" => "a211cdce0352c5e50c5fc38818ae34c2af40543125232efc7647141bf1ac62bb",
        "darwin_amd64" => "23599457fd9b917f3081fd68e70e851d9fb50aa690e5677de55958f28309aec4",
        "linux_arm64"  => "e21baac53e5c3e39419b862e44eb23297a7884eb1c5225c07f9d7c28d01c8fd6",
        "linux_amd64"  => "ba7d3b3940e1c61e4661311df5e059f52711c71188480c1eb6ca92180f49707e",
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
