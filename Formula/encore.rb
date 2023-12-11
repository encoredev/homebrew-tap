class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.4"
    checksums = {
        "darwin_arm64" => "6c4fe5f84cff99ec05672e3e80399299f47d6546593007719cfb32fc388faa9a",
        "darwin_amd64" => "13a9b00cca6ecc9da89c4e0753356aa55af47abb1e8137fdd173c580a8c2d26f",
        "linux_arm64"  => "2d32595dde7d530a93c950fcf7e60e6122bfd5ca5298253c11463c8639e8fe06",
        "linux_amd64"  => "014e4d2d7549e2bf952f6122734cb37b5947824a12f51322684450f3622ba509",
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
