class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.22"
    checksums = {
        "darwin_arm64" => "e23c9abf1981a9625d7043c3349088ac6a4ed22ced296bc916894ddcaf5056b5",
        "darwin_amd64" => "7395e3c20276479fec7988c62dafe0124891b61a809202bed9e64e4c274c4db3",
        "linux_arm64"  => "ff0af1f69da19227037b8592ce610d7edcb27142f4109875f3dad1e5d411b51f",
        "linux_amd64"  => "7ea425330a9abc5d69d3100d0e31f90ba87882572aa9564a2abc3fba7302cbdd",
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
