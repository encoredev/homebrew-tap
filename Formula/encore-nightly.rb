class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231014"
    checksums = {
        "darwin_arm64" => "e02664e34822e6fca29e692e09d95deed385b5a3df90b8eec12de4d440bfb1e0",
        "darwin_amd64" => "df8dda46e66f2d330cf81aa83d2dd4ec918c79c51c142d565b2c0adbb926641d",
        "linux_arm64"  => "5047e844867500a428360a986795d8843bcfa6d8bbc7983857a31469e6efcb67",
        "linux_amd64"  => "ee2e5b82ce3ab023158ea66042fa21393af7404bdf612634528406973a7d2680",
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
