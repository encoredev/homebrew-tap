class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221209"
    checksums = {
        "darwin_arm64" => "c98cc275cad32a3b3ae9fe625ce6b6d1fce1aeb9feeb79d55156e989cbae3095",
        "darwin_amd64" => "75f80c546dc87a6697ab988f729343d10bb7696520927ebbe185f42400caf44a",
        "linux_arm64"  => "4f7e0acaa0bd872ec38c19c6665d5e168d13a1b444b9d685c780a47b4f37872b",
        "linux_amd64"  => "6f999ad5f054155322f1ee66f9b43848debe801d61b7f9073790c29031ad9d77",
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
