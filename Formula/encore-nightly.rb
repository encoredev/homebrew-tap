class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230827"
    checksums = {
        "darwin_arm64" => "106d4a2416ebb150ba83950d301bf847784dcd9a8f8eea0ff09cf91f8fe3dd18",
        "darwin_amd64" => "8e048a84af5c3cfcc6ebab9739b8322ab071491b575914bcb07d23a9aaf2a264",
        "linux_arm64"  => "f0c143f9688934a74bb6d3d21aefda0b2bf00bc625c20914e6f88853b9410782",
        "linux_amd64"  => "1d2d2bfc7b3b8b66b045858f2dd2911d75340a803350ad34931b69714097c159",
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
