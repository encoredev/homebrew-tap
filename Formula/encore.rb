class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.50.6"
    checksums = {
        "darwin_arm64" => "cbadea5d514243b4b02a76efd5a6f7ae662974d2413f1dccfc3e251a64a3593a",
        "darwin_amd64" => "12007ffd1c88cf8604d87c88769636dec9dbbf7013075093d878a98b9f512f81",
        "linux_arm64"  => "328a99222ec76e0dbd2b3dbb5f2f63d89c3f54871329d3136759c7b248ce38bc",
        "linux_amd64"  => "bcb6557589eef6cc3b7b6cb8d674560c5a95091e2caaf8d50d96c11a235431c4",
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
