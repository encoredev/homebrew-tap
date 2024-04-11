class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.35.1"
    checksums = {
        "darwin_arm64" => "59a8d9a28b0638f64d9d02525cda275f7a1fe8ebdf0628b8010196a063b4c8f4",
        "darwin_amd64" => "509327b2489156ef5dfd02a000377b93d8267e11448d85883101db3c4228c5ad",
        "linux_arm64"  => "3b3efd76f58b7c64284604fed5d883e0c15e27a9a45da2986a969649d0b23f01",
        "linux_amd64"  => "613fb80a28598e8a79ef7f91e82f74cd16a1de0bf14905076b1cf0094f1fce5e",
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
