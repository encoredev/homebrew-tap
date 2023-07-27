class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230727"
    checksums = {
        "darwin_arm64" => "ea4d1dbceb3b07e9059546fddc538e2b5ba529d9198383b659d0df9871110c98",
        "darwin_amd64" => "1dc13678f26b13a731ef97a9faa9a1ca108818a1251b5a3b2622a661ea28b0f6",
        "linux_arm64"  => "c21b7aa88feb5521342ad558ecd3d86b5aadba952c5efa52fc994796c62893ad",
        "linux_amd64"  => "ef162275045ded8517e5f095fae430c07bf6ee9e35aa7c057d54b6d4f670d4ac",
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
