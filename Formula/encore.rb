class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.52.1"
    checksums = {
        "darwin_arm64" => "cf30d81a0f94bd951e2e45a33faba2b64ca447617251da3e855ccea6e6e5cb22",
        "darwin_amd64" => "fb871f7f835daaa0998e7f4386713f11c4c867a4a3ac7fbcde0c03b4608d8072",
        "linux_arm64"  => "79ecca615e42ebc5fba8ffd6fdf0febb1e00cb5ae6b4b22d0863f96fd81df34d",
        "linux_amd64"  => "0a851e1337ac76c17fb71d81ad85c2c98509ac7867a9e64af57128d5d26fa2f2",
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
