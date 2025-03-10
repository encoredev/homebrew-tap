class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.7"
    checksums = {
        "darwin_arm64" => "1ed95b4aca63c847b3d2725796f5613dcd2383bbe6d62043aed83f1f91d160bc",
        "darwin_amd64" => "24508afd3a0a6df9b7f4406fb34f04eb43e571ab88478434284b808669cb66b1",
        "linux_arm64"  => "0ad59be26020b36c01aaa8e183d3f7c2afeefdc0439f426a46796b722b100a67",
        "linux_amd64"  => "dde92d5e7b4a3c66a36fff30cc529d15617013c62c7c7ae34dfd803beebaf1ca",
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
