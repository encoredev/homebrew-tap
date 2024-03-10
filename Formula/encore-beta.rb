class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.33.5-beta.7"
    checksums = {
        "darwin_arm64" => "8e0d216ede38327ccd195dfe72e9f9632d1bd5408e65c809af251b610522f26d",
        "darwin_amd64" => "40a86695417e69e1b24a6f3ec19189df8309e56b50d7bef4199ee7fb5f9e3891",
        "linux_arm64"  => "da6c84a14f225645fe3e66f6292b232053eb324fe4b3cad1cfa2016b7954ff15",
        "linux_amd64"  => "11d84548425ecd9cef4b2fb930b6d493ef5fb3dd0d88b727d6504a2d008dccb2",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
