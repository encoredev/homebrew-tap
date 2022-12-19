class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221219"
    checksums = {
        "darwin_arm64" => "6042e3a8f59fa6d11a9c29c198e6440bc6bb518f5bbc52031bf2e322c41c149b",
        "darwin_amd64" => "75be9228551461528d2b3ca5211f4b48dbb73dce619a41a165978cf01bf63b47",
        "linux_arm64"  => "73b3c7ea837f44241b1a82910fb716ecc1cb1a7b53c96351b9b665db717f580a",
        "linux_amd64"  => "e54fd40a6a012b12b092decba904455928646a729be4558db0b47430705b8f85",
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
