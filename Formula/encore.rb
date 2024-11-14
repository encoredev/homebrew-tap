class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.11"
    checksums = {
        "darwin_arm64" => "76ea1103831bab0b23e3d33dca65678ab58f9a4799f5bb2c87ebe507bdc8e87e",
        "darwin_amd64" => "dd8012e3584a257b972245c788a81fc78bddf15c88e30321a90394af37c3962b",
        "linux_arm64"  => "6387921939b505db155b156d2b5738cd4aafbf3ce0eb72b9b8dafcf988a386d2",
        "linux_amd64"  => "d4ceda6ca0be32bf69f2a8d1c14dc2d98bc49f73e5d94a94a2c81a049aec9e22",
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
