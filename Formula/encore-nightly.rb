class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.0-nightly.20240308"
    checksums = {
        "darwin_arm64" => "438771488410da878066b378ca330ac16c6dc3b48e4925e013f6fcb61ea58ce0",
        "darwin_amd64" => "60cfa0ed58c9454fedf7a81b9ddb806ed3c3a97a7b84492a1a93895762b4233b",
        "linux_arm64"  => "18405c3668317b6880c0a95a90f077c68791ca4668169ea8ed4b4d3bd2b21c39",
        "linux_amd64"  => "4fcd30570660491089ef42c4bca1ab7be4862a36e7ad8686a81ff1d7ff2eee39",
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
