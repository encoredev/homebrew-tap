class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230908"
    checksums = {
        "darwin_arm64" => "480b1d23a8ef2ded28e7dda151b0306370eef198426268b0abd23f353e8fa9d4",
        "darwin_amd64" => "14c774355e7768d50f9ebf7eac1a198789820596bc0d8dab7f9af0c1efdf3a3a",
        "linux_arm64"  => "7db13621cfbaa4b27bbb9c9598272b1263df4d83329f08f59e094fb8066f18a7",
        "linux_amd64"  => "841c153185ac9e46fd8c93633389f97085ce4897621132e3b0a9e78fefd2d3a0",
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
