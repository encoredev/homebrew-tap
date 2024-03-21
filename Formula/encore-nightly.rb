class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.35.0-nightly.20240321"
    checksums = {
        "darwin_arm64" => "5641df588be247d7f806323f03290fa56eac34a570c8d4cc5bb22ef27bbba5c3",
        "darwin_amd64" => "d490a8a7538c048380efd5155c01f5a2ca5d519d4e0b68745de181fcffce879c",
        "linux_arm64"  => "284908802be27f8f88c11c1673f9f549ea14a9e8766bf05ab6caf13292291ade",
        "linux_amd64"  => "a27b222075518a895350d76b8816dd10d9d63cebe1e6a941d1cbf8acb9b20ded",
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
