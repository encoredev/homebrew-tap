class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.0-nightly.20240307"
    checksums = {
        "darwin_arm64" => "d72ab8af1a7672c91bbce0980748387fdeb4582b56ecefcdc41b1e8eb209953e",
        "darwin_amd64" => "a58f2e73991281cc1cabb8948cda95310851495dea1dfb8977994c78c7e80e1e",
        "linux_arm64"  => "2deb5ee0e83050e17c7df7657d485966bb8e55896c6f6dc2c166051e0661830f",
        "linux_amd64"  => "047cd2725ed51e61bcae7a418f5f030ab64293cd86b6b6a62b453f3a60490b12",
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
