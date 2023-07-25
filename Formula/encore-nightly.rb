class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230725"
    checksums = {
        "darwin_arm64" => "613089a89dde8286e7b35135fb68fc3d1c963aecc8f18bf01245ebc9c9b44179",
        "darwin_amd64" => "8bc8080a9a29aac76e98d93598cf60d11267fa49f72fcb5938254dac3d4201be",
        "linux_arm64"  => "931b99e47a064cde0a9159be0f5eccc09920bce8ec3daf452cfe1e400ad7fc93",
        "linux_amd64"  => "e672afd67d87bc834694a59576619e0611e2671f6bf9d172ad3ccc2f701fd2c8",
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
