class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.0-nightly.20240303"
    checksums = {
        "darwin_arm64" => "8e729f373d47c78f4f19853a31f48cf02cae44cd9dede8c8ea7bbd5235f2a90d",
        "darwin_amd64" => "e242df41c230eeb065fbca1c2c10d90474aa9d91c9b516fedc4f2985107dfd9e",
        "linux_arm64"  => "4c1425830ccf75e4932c568dbd57d3210024b833e65696f4bea9730c480a8ea6",
        "linux_amd64"  => "7f1e4def90a8be63dc1248fdac1ed1779576b3c6083271af227ce9765fcb7d4b",
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

        bin.install_symlink libexec/"bin/encore-nightly"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "bash")
        (bash_completion/"encore-nightly").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "zsh")
        (zsh_completion/"_encore-nightly").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "fish")
        (fish_completion/"encore-nightly.fish").write output
    end

    test do
        system "#{bin}/encore-nightly", "check"
    end
end
