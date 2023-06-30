class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230630"
    checksums = {
        "darwin_arm64" => "5474140c2b87a7468cf97aee2b91d2af52f8b1b2709c0fc6557e23cc23ecb396",
        "darwin_amd64" => "52637c7e658b4cf625284da8c6db78bc084bd823dbbbd3d89ebdeb84dbbe1b6e",
        "linux_arm64"  => "e68d1d8ba73bb82bf5153e64714180b85533c8a6114729793af6e2025143752b",
        "linux_amd64"  => "5e751ebcecad7cfd50e05099821c490360bedfdebee17c87cf7857792eb59354",
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
