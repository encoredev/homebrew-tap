class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.28.0"
    checksums = {
        "darwin_arm64" => "66871d9ec15fbd358605523a22f9646375d0112d19e4c450d0d95ec4d8e27735",
        "darwin_amd64" => "4ef8af23ebb6db7a0374d0754a19b5e14e8948cae3dbd57d899afdca9d0d7862",
        "linux_arm64"  => "29e85e46c60b3c568ed670caaf2087a61a585a9c6ba9b02ba47cfd5e31d6c299",
        "linux_amd64"  => "067baf3721a1589365a8714ef9c2075a9da26222dc21dde328e92bfee92c7675",
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
