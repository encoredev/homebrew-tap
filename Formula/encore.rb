class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.18.0"
    checksums = {
        "darwin_arm64" => "0b0774f846d96194958e2505ce97a3ae097091a39128df8fefbb0ee98de8aeaa",
        "darwin_amd64" => "e056d9c28fe36509bcb1f49ad81a2a16a8c821b5b97d75adbc6c413e6bd647cb",
        "linux_arm64"  => "38a2866c93bac7c8f8a998147a3581c3c05d927a68b055d9751de238ecde11a1",
        "linux_amd64"  => "456933511295590138b986489c9c0d11fa9d5d087d5b0ea0c180818f13aff3d9",
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
