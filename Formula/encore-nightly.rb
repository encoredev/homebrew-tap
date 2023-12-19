class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.30.0-nightly.20231219"
    checksums = {
        "darwin_arm64" => "334736e8c2ae92a1c4efa91b60b75a93c773b0e56fe73c0900c8785dbbc2ab92",
        "darwin_amd64" => "40395319be6723f52b49958981df35f1ff67a6ab88881910b6f9530b1427f375",
        "linux_arm64"  => "730fea41539fbceb1a4c90bfe45e2b79218402eee81d317cf55cee09927774ad",
        "linux_amd64"  => "95d69b0206a74149bf61e26d1611b2a4e69de876b8031cee9a141cc558f08715",
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
