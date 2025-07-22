class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.11"
    checksums = {
        "darwin_arm64" => "375d0c5e07c136be5d9ac3a28260ebfa57d5227bff9e66c97c12a0d3f6e75812",
        "darwin_amd64" => "f0e93b6859885fea0bb9c51b4e889e7dea4ecd60ff6f42dd9e4bd52eb6697f0b",
        "linux_arm64"  => "fecb051b2e11edbfc30f1eeb0d47c5ec4fa5f1f9408d86b78a34af301527b2f2",
        "linux_amd64"  => "493e0e445779531464d94c9364da403cfa4cfd821453743f414f5e1cb1e4bdd2",
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
