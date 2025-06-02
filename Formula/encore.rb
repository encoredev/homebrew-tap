class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.3"
    checksums = {
        "darwin_arm64" => "364fcf28391c8d594314cf680bbcf5a3d7f852bb67e4bdffdd55a2f04b51ad01",
        "darwin_amd64" => "558aaea33f8ef1b96d1a02ef2e3f744f3210a4b23a8f890165c45a974f8156b5",
        "linux_arm64"  => "67bc36264cadd0a7206f4e15ffd6f3703aab35320b0f6af908cc7342397abec4",
        "linux_amd64"  => "f319b900e9e7dfa47e37f208875255928fb71704fbcdb188054f64ffe9431f37",
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
