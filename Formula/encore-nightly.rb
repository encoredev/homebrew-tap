class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.0-nightly.20240304"
    checksums = {
        "darwin_arm64" => "d9be12bb16662d4574abffdd9abee3573d6ef61d8b1b6a694998154d826ee970",
        "darwin_amd64" => "8f7f20d14d0af5d4c2088ee3708716f17860aa1fdd576b43da1ea4fc9e76b262",
        "linux_arm64"  => "8822d0ab9f769a8179f65ff3e6b57cd63379eefe7a6eba1a80a4223a78f6c1ae",
        "linux_amd64"  => "fb67c8c2abe4ec529f420bddf2de532b2d6ca7f51d2e8535582175c65350346e",
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
