class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230705"
    checksums = {
        "darwin_arm64" => "1bd210b8e14d517a283fabfab58716d8dba0c1b49acdaf1b548b68a263a73780",
        "darwin_amd64" => "d26a4ee2bd11187a80f8a74793df8e5c9e0814e561b567ab9fce9e5925da0b4d",
        "linux_arm64"  => "8f7031c47065081dbc520acde8c63166fb4650f04f1c1716dfbf667c405e65ee",
        "linux_amd64"  => "e0604e37d99823398847169a846c1c85c6f4f45f980f91d7192e66d6a568bd5d",
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
