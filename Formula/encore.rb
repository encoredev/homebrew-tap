class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.6"
    checksums = {
        "darwin_arm64" => "c1320539851a76a68a8b8978e43fea9e6547d31c2a58151f1cd47425df6afbce",
        "darwin_amd64" => "a912c526dc3fc639a717df1683792a6381c67fd12b008cefa90aff2121dba0e3",
        "linux_arm64"  => "5397c87ef71deceafe1259310b616a91d433c7b4f0fb5dbb4b8add1ee8209932",
        "linux_amd64"  => "e8824486093a9eb01916c278a74a2f1c712ce1df0cee7e0b54b1c315aacad07d",
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
