class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.13.4"
    checksums = {
        "darwin_arm64" => "d306a91b5c4be6c49790adcbf3f7ee8b63a5097c7ee28c204f92791fa5b213f5",
        "darwin_amd64" => "6ae7077ab6e3bb840cd674cf3a61a4610172671861ca05c77e8ec522cc0ab2f6",
        "linux_arm64"  => "a4fe2aa2abc4d85ab45abac80b12b07d5afd0d18367765a2f179580f4b51655a",
        "linux_amd64"  => "9ff6bc69f07c4fcb0737b7b1b8bf8adcd095eb7c334d0954a383022bf8cb481d",
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
