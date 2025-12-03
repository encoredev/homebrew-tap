class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.52.3"
    checksums = {
        "darwin_arm64" => "ea9d3e66367b04d22130f3f95e546ef9c1649dd86f72965b66b2efaf9dfe2cd2",
        "darwin_amd64" => "6b65781f0e96954095670f83ca759e6b4b16196e7830bbb421831753f085c4aa",
        "linux_arm64"  => "dd26902c9b13862ac65ef8e2045b88e6915c9b2c37b9a3cdd95fe0d7c1ee168d",
        "linux_amd64"  => "d17c29ef072395cebd3706862c61ba6030934380b358fa91847b174c8d62deff",
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
