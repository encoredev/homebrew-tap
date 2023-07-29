class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230729"
    checksums = {
        "darwin_arm64" => "2a77edd50d122498618c7ea9d7c8cbc4414e14bc05eb4145a97595372ee4037e",
        "darwin_amd64" => "6da6fc316caf5a951e0b429b94b7bfd3e600eda4c2de8b5e08bfd7caa9635e1a",
        "linux_arm64"  => "037b0495f572aad6826418bb9eae716bd3be4e678146419234591c03f109c7fe",
        "linux_amd64"  => "85298bb67283d1752a8b8c416b1d906079a50ee22d62c60be9da4d1285083e94",
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
