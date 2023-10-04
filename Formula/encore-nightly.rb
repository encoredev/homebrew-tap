class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231004"
    checksums = {
        "darwin_arm64" => "e63b04787cac676da4df10a1fafbedf55dd020b42ead0e543d8e7ceb5184e9d8",
        "darwin_amd64" => "21143db6fa9e341a64bc6f6c559db904a33c6e67f4d1a9c0692a2370f303d6de",
        "linux_arm64"  => "bb45e349dc926e2ad2ac1b12d7c019c74fc10ff0cfd0647f56f8954435db9361",
        "linux_amd64"  => "6770f5ce55bf09f4330c5a29a9fdf8b062338f0d988bd6a521acd05d2852f0da",
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
