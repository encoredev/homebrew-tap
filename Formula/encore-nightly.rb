class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.0-nightly.20240306"
    checksums = {
        "darwin_arm64" => "58405ab5768bcd7c5f64c4185e5c01bac9c6ddb58686e78f0795f3a5657526fd",
        "darwin_amd64" => "b56683b88100fc1c9883c5c165ce791a2ede992a0252631bd26076c97179979f",
        "linux_arm64"  => "ee2351e38dcba853ca65f358c6f3aff5541d211e4b068450747d8dc851cfeb64",
        "linux_amd64"  => "c823dbbc6e0edfe55a0c4b085e41610f2b0ae8f29ea50f95d5697e626b442d44",
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
