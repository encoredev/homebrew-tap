class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.38.10"
    checksums = {
        "darwin_arm64" => "13e918b3cb303d22b069190549bd354e2869c8b3d6c2f41eaf3fb4ba86e7856f",
        "darwin_amd64" => "cb17876e69bfae68ed962d1de5c47c443d8c4861fb0b30078ae00929e282aab3",
        "linux_arm64"  => "7b8c28c2ddfade9110763e35f68c6251ad6f052bcd668077f21c3adf37c91fa2",
        "linux_amd64"  => "725255213f50cc4c126e9a7f864dbc30169c1803febf6da7e6c016af172dc69c",
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
