class EncoreATnightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221022"
    checksums = {
        "darwin_arm64" => "4de84fc05f7513fbc08f9465f34d82bcaf67799ff5116af8d5c0b928d07a7ebe",
        "darwin_amd64" => "34ab82925fedff09ef162fab6c45cbc2423619de8e8a499f606c29ec7203a580",
        "linux_arm64"  => "964d846c2e2b01d59ec6b27228bbc3209b82b10e762b7895deb7fb15ac809486",
        "linux_amd64"  => "b3139a78480137315511c58ed224defe9eb3d555137d235116ff1673179367fb",
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
