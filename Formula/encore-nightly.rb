class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.30.0-nightly.20231122"
    checksums = {
        "darwin_arm64" => "cdfa6a32ca126df530fd79defa63cf4a4b8c5e9e65e7acdcfe97bac89fb9f09a",
        "darwin_amd64" => "ea381a6f62f58d0260a5ac155bb22ce85b76316d93e61046065247cb09cc2f11",
        "linux_arm64"  => "7fc660270904da406e96323c637f0d7c4074d83ebb82fa05321244c733ec1ba1",
        "linux_amd64"  => "a570a88bc47d462ad877030bc21baddc1c514d5a90d46a7a0d3de1df0ec88a24",
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
